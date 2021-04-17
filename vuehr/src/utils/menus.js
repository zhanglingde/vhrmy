import {getRequest} from "./api";
// 菜单工具类：调用接口获取数据库中的菜单，并将菜单字段格式化成vue路由时需要的格式，并存储到vuex中

// 定义一个方法
export const initMenu = (router, store) => {
    if (store.state.routes.length > 0) {
        // 有菜单数据
        return;
    }

    // 调用后端接口初始化菜单数据
    getRequest("/system/config/menus").then(data => {
        if (data) {
            // 查询数据库请求成功，data为返回的菜单数据
            // 将数据库中组件字符串转换成 前端对象
            let fmtRoutes = formatRoutes(data);
            router.addRoutes(fmtRoutes);
            // 调用store中mutations的initRoutes存储菜单数据
            store.commit('initRoutes',fmtRoutes);
        }
    })
}
// 格式化组件
export const formatRoutes = (routes) => {
    let fmRoutes = [];
    routes.forEach(router => {
        // 批量变量定义
        let {
            path,
            component,
            name,
            meta,
            iconCls,
            children
        } = router;
        if (children && children instanceof Array) {
            // 一级菜单的children，递归调用
            children = formatRoutes(children);
        }
        let fmRouter = {
            path: path,
            name: name,
            iconCls: iconCls,
            meta: meta,
            children: children,
            // 动态加载(动态导入组件)
            component(resolve) {
                require(['../views' + component + '.vue'], resolve);
            }
        }
        fmRoutes.push(fmRouter);
    })
    return fmRoutes;
}