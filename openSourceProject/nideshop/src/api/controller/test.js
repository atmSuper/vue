const Base = require('./base.js');
module.exports = class extends Base {
    async indexAction(){
      const channerId = this.get('id');
      const value =this.get('url')
      const model = this.model('channel');
      if(channerId&&value) {
        await model.where({id: channerId}).update({icon_url:value});
      }else {
        return this.fail(1002, 'error message');
      }
      return this.success();
  }
  async addAction() {
    const goodsCount = await this.model('goods').where({is_delete: 0, is_on_sale: 1}).count('id');

    return this.success({
      goodsCount: goodsCount
    });
  }
}