package cn.enilu.flash.bean.entity.front;

import cn.enilu.flash.bean.entity.front.sub.OrderBasket;
import cn.enilu.flash.bean.entity.front.sub.OrderStatusBar;
import cn.enilu.flash.bean.entity.front.sub.OrderTimelineNode;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * Created  on 2018/1/5 0005.
 *
 *@Author enilu
 */
@Document(collection = "orders")
@Data
public class Order extends BaseMongoEntity {
    //等待支付
    public static  final Integer STATUS_INIT = 0;
    //已支付
    public static  final Integer STATUS_PAID = 1;
    //制作中
    public static  final Integer STATUS_DOING = 2;
    //派送中
    public static  final Integer STATUS_DELIVERYING= 3;
    //完成订单
    public static  final Integer STATUS_DONE = 4;
    //完成订单
    public static  final Integer STATUS_CANCEL = -1;


    @Id
    private String _id;
    private Long id;
    private Integer total_amount;
    private Integer total_quantity;
    private Long unique_id;
    private Long user_id;
    private Long address_id;
    private Integer top_show=0;
    private OrderBasket basket = new OrderBasket();
    private OrderStatusBar status_bar;
    private OrderTimelineNode timeline_node;
    private String formatted_create_at;
    private Long order_time;
    private Integer time_pass=900;
    private Integer is_brand=0;
    private Integer is_deletable=1;
    private Integer is_new_pay=1;
    private Integer is_pindan=0;
    private Integer operation_confirm=0;
    private Integer operation_rate=0;
    private Integer operation_rebuy=2;
    private Integer operation_pay=0;
    private Integer operation_upload_photo=0;
    private Integer pay_remain_seconds=0;
    private Integer rated_point=0;
    private Integer remind_reply_count=0;
    private Long restaurant_id;
    private String restaurant_image_hash;
    private String restaurant_image_url;
    private String restaurant_name;
    private Integer restaurant_type=0;
    /**
     * 订单状态
     */
    private Integer status_code=STATUS_PAID;

    public static String getStatusCodeStr(Integer status_code){
        switch (status_code){
            case -1:
                return "已取消";
            case 0:
                return "等待支付";
            case 1:
                return "已支付";
            case 2:
                return "制作中";
            case 3:
                return "派送中";
            case 4:
                return "订单完成";

        }
        return "";
    }
    @JSONField(name="_id")
    public String get_id() {
        return _id;
    }
    @JSONField(name="_id")
    public void set_id(String _id) {
        this._id = _id;
    }
}
