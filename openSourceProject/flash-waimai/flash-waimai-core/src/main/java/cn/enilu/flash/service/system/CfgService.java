package cn.enilu.flash.service.system;

import cn.enilu.flash.bean.entity.system.Cfg;
import cn.enilu.flash.bean.vo.query.SearchFilter;
import cn.enilu.flash.cache.ConfigCache;
import cn.enilu.flash.dao.system.CfgRepository;
import cn.enilu.flash.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * CfgService
 *
 *@Author enilu
 * @version 2018/11/17 0017
 */

@Service
@Transactional
public class CfgService extends BaseService<Cfg, Long, CfgRepository> {
    @Autowired
    private ConfigCache configCache;

    public Cfg saveOrUpdate(Cfg cfg) {
        if(cfg.getId()==null) {
            insert(cfg);
        }else{
            update(cfg);
        }
        configCache.cache();
        return cfg;
    }

    public Cfg getByCfgName(String cfgName) {

        return get(SearchFilter.build("cfgName", SearchFilter.Operator.EQ,cfgName));
    }

    /**
     * 根据参数名获取参数值
     * 系统获取参数值统一使用该方法
     * 如果参数无法做到后台管理系统和用户端系统同步，这里建议直接从数据库获取
     * todo 建议生产中使用redis来统一管理该参数，这里从redis缓存中获取
     * @param cfgName
     * @return
     */
    public String getCfgValue(String cfgName) {
//        return configCache.get(cfgName);
        return getByCfgName(cfgName).getCfgValue();
    }
    @Override
    public void delete(Long id) {
        super.delete(id);
        configCache.cache();
    }

}
