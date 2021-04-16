// NodeJs配置代理，请求转发前端请求

let proxyObj = {};
proxyObj['/'] = {         // 拦截http请求
    ws: false,           // 不拦截websocket请求
    target: 'http://localhost:8081',        // 转发地址
    changeOrigin: true,
    pathRewrite: {
        '^/': ''                                // 拦截地址不修改（此处可修改拦截地址）
    }
}

module.exports = {
    // 开发环境代理对象
    devServer: {
        host: 'localhost',
        port: 8080,
        proxy: proxyObj
    }
}
