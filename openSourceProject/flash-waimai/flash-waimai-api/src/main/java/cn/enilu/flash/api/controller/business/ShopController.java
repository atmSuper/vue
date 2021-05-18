package cn.enilu.flash.api.controller.business;

import cn.enilu.flash.api.controller.BaseController;
import cn.enilu.flash.bean.constant.factory.PageFactory;
import cn.enilu.flash.bean.entity.front.Ids;
import cn.enilu.flash.bean.entity.front.Menu;
import cn.enilu.flash.bean.entity.front.Ratings;
import cn.enilu.flash.bean.entity.front.Shop;
import cn.enilu.flash.bean.entity.system.Cfg;
import cn.enilu.flash.bean.enumeration.ConfigKeyEnum;
import cn.enilu.flash.bean.vo.business.CityInfo;
import cn.enilu.flash.bean.vo.business.ShopVo;
import cn.enilu.flash.bean.vo.front.Rets;
import cn.enilu.flash.dao.MongoRepository;
import cn.enilu.flash.security.AccountInfo;
import cn.enilu.flash.security.JwtUtil;
import cn.enilu.flash.service.front.IdsService;
import cn.enilu.flash.service.front.PositionService;
import cn.enilu.flash.service.system.CfgService;
import cn.enilu.flash.utils.*;
import cn.enilu.flash.utils.factory.Page;
import cn.enilu.flash.utils.gps.Distance;
import org.nutz.json.Json;
import org.nutz.lang.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.geo.GeoResult;
import org.springframework.data.geo.GeoResults;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created  on 2018/1/2 0002.
 *
 *@Author enilu
 */
@RestController
@RequestMapping("/shopping")
public class ShopController extends BaseController {
    @Autowired
    private MongoRepository mongoRepository;
    @Autowired
    private IdsService idsService;
    @Autowired
    private PositionService positionService;
    @Autowired
    private CfgService cfgService;

    @RequestMapping(value = "/restaurant/{id}", method = RequestMethod.GET)
    public Object getShop(@PathVariable("id") Long id) {
        Object data = mongoRepository.findOne(id, "shops");
        return Rets.success(data);
    }

    /**
     * 后台管理查询商户列表
     *
     * @param name        商铺名称
     * @param state       审核状态
     * @param categoryIds
     * @return
     */
    @RequestMapping(value = "listShop", method = RequestMethod.GET)
    public Object listShop(
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "state", required = false) String state,
            @RequestParam(value = "restaurant_category_ids[]", required = false) Long[] categoryIds) {
        AccountInfo accountInfo = JwtUtil.getAccountInfo();
        if (Constants.USER_TYPE_SHOP.equals(accountInfo.getUserType())) {
            Page<Shop> page = new PageFactory<Shop>().defaultPage();
            return Rets.success(mongoRepository.queryPage(page, Shop.class, Maps.newHashMap("id", accountInfo.getUserId())));
        }
        Map<String, Object> params = Maps.newHashMap();
        if (StringUtils.isNotEmpty(name)) {
            params.put("name", name);
        }
        if (StringUtils.isNotEmpty(state)) {
            params.put("state", state);
        }

        Page<Shop> page = new PageFactory<Shop>().defaultPage();
        return Rets.success(mongoRepository.queryPage(page, Shop.class, params));

    }


    /**
     * 用户端查询商铺列表
     *
     * @param latitude
     * @param longitude
     * @param name        商铺名称
     * @param categoryIds
     * @return
     */
    @RequestMapping(value = "restaurants", method = RequestMethod.GET)
    public Object restaurants(@RequestParam(value = "latitude", required = false) String latitude,
                              @RequestParam(value = "longitude", required = false) String longitude,
                              @RequestParam(value = "name", required = false) String name,
                              @RequestParam(value = "restaurant_category_ids", required = false) Long[] categoryIds) {


        Map<String, Object> params = Maps.newHashMap();
        if (StringUtils.isNotEmpty(name)) {
            params.put("name", name);
        }
        params.put("disabled",0);

        if (StringUtils.isEmpty(latitude) || "undefined".equals(latitude)
                || StringUtils.isEmpty(longitude) || "undefined".equals(longitude)) {
            Page<Shop> page = new PageFactory<Shop>().defaultPage();
            return Rets.success(mongoRepository.queryPage(page, Shop.class, params));
        } else {
            //查询指定经纬度范围内的餐厅
            if (categoryIds != null && categoryIds.length > 0) {
                Map map = (Map) mongoRepository.findOne(categoryIds[0], "categories");
                if (map != null) {
                    params.put("category", map.get("name").toString());
                }
            }
            GeoResults<Map> geoResults = mongoRepository.near(Double.valueOf(longitude), Double.valueOf(latitude), "shops", params);
            Page<Map> page = new PageFactory<Map>().defaultPage();
            if (geoResults != null) {
                List<GeoResult<Map>> geoResultList = geoResults.getContent();
                List list = Lists.newArrayList();
                for (int i = 0; i < geoResultList.size(); i++) {
                    Map map = geoResultList.get(i).getContent();
                    Distance distance = new Distance(Double.valueOf(longitude), Double.valueOf(latitude),
                            Double.valueOf(map.get("longitude").toString()), Double.valueOf(map.get("latitude").toString()));
                    map.put("distance", distance.getDistance());

                    map.put("order_lead_time", "30分钟");
                    list.add(map);
                }

                page.setTotal(list.size());
                page.setRecords(list);
            }
            return Rets.success(page);
        }
    }

    @RequestMapping(value = "/restaurants/count", method = RequestMethod.GET)

    public Object countShop() {
        long count = mongoRepository.count(Shop.class);
        return Rets.success("count", count);
    }

    @RequestMapping(value = "/restaurants/{id}", method = RequestMethod.DELETE)

    public Object deleteShop(@PathVariable("id") Long id) {
        mongoRepository.delete(id, "shops");
        return Rets.success();
    }

    /**
     * 审核商铺
     *
     * @param shop
     * @return
     */
    @RequestMapping(value = "/auditShop", method = RequestMethod.POST)
    public Object auditShop(@ModelAttribute Shop shop) {
        Map<String, Object> updateMap = new HashMap<String, Object>(4);
        updateMap.put("auditRemark", shop.getAuditRemark());
        updateMap.put("state", shop.getState());
        mongoRepository.update(shop.getId(), "shops", updateMap);
        return Rets.success();
    }

    /**
     * 停用/启用商铺
     *
     * @param shop
     * @return
     */
    @RequestMapping(value = "/stopShop", method = RequestMethod.POST)
    public Object stopShop(@ModelAttribute Shop shop) {
        Map<String, Object> updateMap = new HashMap<String, Object>(2);
        updateMap.put("disabled", shop.getDisabled());
        mongoRepository.update(shop.getId(), "shops", updateMap);
        return Rets.success();
    }

    /**
     * 编辑商铺
     *
     * @param shop
     * @return
     */
    @RequestMapping(value = "/updateshop", method = RequestMethod.POST)
    public Object updateShop(@ModelAttribute @Valid Shop shop) {
        AccountInfo accountInfo = JwtUtil.getAccountInfo();

        Map<String, Object> updateMap = new HashMap<String, Object>(16);
        updateMap.put("name", Strings.sNull(shop.getName()));
        updateMap.put("address", Strings.sNull(shop.getAddress()));
        updateMap.put("description", Strings.sNull(shop.getDescription()));
        updateMap.put("category", Strings.sNull(shop.getCategory()));
        updateMap.put("phone", Strings.sNull(shop.getPhone()));
        updateMap.put("rating", Double.valueOf(shop.getRating()));
        updateMap.put("recent_order_num", shop.getRecent_order_num());
        updateMap.put("image_path", shop.getImage_path());
        updateMap.put("platform_rate",shop.getPlatform_rate());

        if(Constants.USER_TYPE_SHOP.equals(accountInfo.getUserType())){
            //商户自己修改需要审核
            updateMap.put("state", Shop.STATE_ING);
        }else{
            //管理员修改直接审核通过
            updateMap.put("state", Shop.STATE_YES);
        }

        mongoRepository.update(shop.getId(), "shops", updateMap);
        return Rets.success();
    }

    @RequestMapping(value = "/addShop", method = RequestMethod.POST)
    public Object addShop(@ModelAttribute @Valid ShopVo shopVo) {

        Shop shop = new Shop();
        BeanUtil.copyProperties(shopVo, shop);
        shop.setId(idsService.getId(Ids.RESTAURANT_ID));
        List activities = Json.fromJson(List.class, shopVo.getActivitiesJson());
        int index = 0;
        for (int i = 0; i < activities.size(); i++) {
            Map activity = (Map) activities.get(i);
            String iconName = activity.get("icon_name").toString();
            switch (iconName) {
                case "减":
                    activity.put("icon_color", "f07373");
                    activity.put("id", index++);
                    break;
                case "特":
                    activity.put("icon_color", "EDC123");
                    activity.put("id", index++);
                    break;
                case "新":
                    activity.put("icon_color ", "70bc46");
                    activity.put("id", index++);
                    break;
                case "领":
                    activity.put("icon_color ", "E3EE0D");
                    activity.put("id ", index++);
                    break;
                default:
                    break;
            }
        }
        shop.setActivities(activities);

        List<Map> supports = new ArrayList<Map>(4);
        if (shopVo.getBao()) {
            supports.add(buildSupport("已加入“外卖保”计划，食品安全有保障", "999999", "保", 7, "外卖保"));
        }
        if (shopVo.getZhun()) {
            supports.add(buildSupport("准时必达，超时秒赔", "57A9FF", "准", 9, "准时达"));
        }
        if (shopVo.getPiao()) {
            supports.add(buildSupport("该商家支持开发票，请在下单时填写好发票抬头", "999999", "票", 4, "开发票"));
        }
        shop.setSupports(supports);
        shop.setIs_new(shopVo.getNews());

        if (shopVo.getDeliveryMode()) {
            Map<String, Object> deliveryMode = Maps.newHashMap("color", "57A9FF", "id", 1, "is_solid", true, "text", "蜂鸟专送");
            shop.setDelivery_mode(deliveryMode);
        }
        Map<String, String> tips = new HashMap<String, String>(2);
        tips.put("tips", "配送费约￥" + shopVo.getFloat_delivery_fee());
        shop.setPiecewise_agent_fee(tips);
        List<String> openingHours = new ArrayList<String>();
        if (Strings.isNotBlank(shopVo.getStartTime()) &&
                Strings.isNotBlank(shopVo.getEndTime())) {
            openingHours.add(shopVo.getStartTime() + "/" + shopVo.getEndTime());
        } else {
            openingHours.add("08:30/20:30");
        }

        shop.setOpening_hours(openingHours);

        Map<String, String> license = new HashMap<String, String>();
        if (Strings.isNotBlank(Strings.sNull(shopVo.getBusiness_license_image()))) {
            license.put("business_license_image", shopVo.getBusiness_license_image());
        }
        if (Strings.isNotBlank(shopVo.getCatering_service_license_image())) {
            license.put("catering_service_license_image", shopVo.getCatering_service_license_image());
        }
        shop.setLicense(license);


        Map<String, String> identification = Maps.newHashMap("company_name", "",
                "identificate_agency", "",
                "identificate_date", "",
                "legal_person", "",
                "licenses_date", "",
                "licenses_number", "",
                "licenses_scope", "",
                "operation_period", "",
                "registered_address", "",
                "registered_number", "");
        shop.setIdentification(identification);


        CityInfo cityInfo = positionService.getPostion(getIp());
        if (cityInfo != null) {
            shop.setLatitude(Double.valueOf(cityInfo.getLat()));
            shop.setLongitude(Double.valueOf(cityInfo.getLng()));
            List locations = new LinkedList();
            locations.add(Double.valueOf(cityInfo.getLng()));
            locations.add(Double.valueOf(cityInfo.getLat()));
            shop.setLocation(locations);
        }
        shop.setPassword("123456");
        shop.setState(Shop.STATE_YES);
        shop.setUnliquidatedAmount("0");
        shop.setTotalAmount("0");
        mongoRepository.save(shop);
        Ratings ratings = mongoRepository.findOne(Ratings.class, Maps.newHashMap("restaurant_id", shop.getId()));
        if (ratings == null) {
            ratings = new Ratings(shop.getId());

            mongoRepository.save(ratings);
        }
        return Rets.success();
    }

    @RequestMapping(value = "addcategory", method = RequestMethod.POST)

    public Object addCategory(@Valid @ModelAttribute Menu menu) {
        menu.setId(idsService.getId(Ids.CATEGORY_ID));
        System.out.println(Json.toJson(menu));
        //todo 进行处理后保存
        mongoRepository.save(menu);
        return Rets.success();
    }

    @RequestMapping(value = "/v2/restaurant/category", method = RequestMethod.GET)
    public Object categories() {
        return Rets.success(mongoRepository.findAll("categories"));
    }

    @RequestMapping(value = "/getcategory/{id}", method = RequestMethod.GET)
    public Object getCategory(@PathVariable("id") Long restaurantId) {
        List list = mongoRepository.findAll("menus", "restaurant_id", restaurantId);
        return Rets.success("category_list", list);
    }


    @RequestMapping(value = "/v2/menu/{id}", method = RequestMethod.GET)
    public Object getMenus(@PathVariable("id") Long id) {
        return Rets.success(mongoRepository.findOne(id, "menus"));
    }

    @RequestMapping(value = "/v2/menu", method = RequestMethod.GET)
    public Object getMenu(@RequestParam("restaurant_id") Long restaurantId, @RequestParam(name = "allMenu", required = false) boolean allMEnu) {
        List<Map> list = mongoRepository.findAll("menus", "restaurant_id", restaurantId);
        return Rets.success(list);
    }

    /**
     * 结算
     * @param id
     * @return
     */
    @RequestMapping(value = "/check", method = RequestMethod.POST)
    public Object check(@RequestParam("id") Long id) {
       Shop shop = mongoRepository.findOne(Shop.class,id);
        String unliquidatedAmount = shop.getUnliquidatedAmount();
        String totalAmount = shop.getTotalAmount();
        if(StringUtils.isEmpty(totalAmount)){
            totalAmount = "0";
        }
        String platformAmount =  new BigDecimal(unliquidatedAmount)
                .multiply(new BigDecimal(shop.getPlatform_rate())).divide(new BigDecimal(100),2, BigDecimal.ROUND_HALF_UP).toPlainString();
       String shopAmount = new BigDecimal(unliquidatedAmount).subtract(new BigDecimal(platformAmount)).toPlainString();
        totalAmount = new BigDecimal(totalAmount).add(new BigDecimal(shopAmount)).toPlainString()+"";
        Cfg cfg = cfgService.getByCfgName(ConfigKeyEnum.SYSTEM_PLATFORM_TOTAL_AMOUNT.getValue());
        cfg.setCfgValue(new BigDecimal(cfg.getCfgValue()).add(new BigDecimal(platformAmount)).toPlainString());
        cfgService.update(cfg);
        shop.setTotalAmount(totalAmount);
        shop.setUnliquidatedAmount("0");
        mongoRepository.update(shop);
        return Rets.success();
    }

    private Map<String, Object> buildSupport(String description, String iconColor, String iconName, Integer id, String name) {
        Map<String, Object> map = new HashMap<String, Object>(8);
        map.put("description", description);
        map.put("icon_color", iconColor);
        map.put("icon_name", iconName);
        map.put("id", id);
        map.put("name", name);
        return map;
    }
}
