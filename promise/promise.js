function Promise(fn) {
    if (typeof this !== 'object') {
        throw new TypeError('Promises must be constructed via new');
    }
    if (typeof fn !== 'function') {
        throw new TypeError('Promise constructor’s argument is not a function');
    }
    this._deferredState = 0; // then的状态
    this._state = 0; // 状态，初始状态是0表示pending,1表示fulfilled,2表示rejected
    this._value = null; // 获取到的值
    this._deferreds = null; //  存储的成功回调和失败回调，以及返回的新Promis的handler
    if (fn === noop) return; // noop 是空函数的意思
    doResolve(fn, this);
}
function doResolve(fn, promise) {
    var done = false;
    var res = tryCallTwo(fn, function (value) {
        if (done) return;
        done = true;
        resolve(promise, value);
    }, function (reason) {
        if (done) return;
        done = true;
        reject(promise, reason);
    });
    if (!done && res === IS_ERROR) {
        done = true;
        reject(promise, LAST_ERROR);
    }
}
function tryCallTwo(fn, a, b) {
    try {
      fn(a, b); // 执行传入promise的方法，并且将resolve和reject方法作为参数传入
    } catch (ex) {
      LAST_ERROR = ex;
      return IS_ERROR;
    }
}

