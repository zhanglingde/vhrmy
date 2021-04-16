// 网络请求封装，统一处理错误
import axios from 'axios'
import { Message } from 'element-ui';

// 响应拦截器拦截错误，统一处理
axios.interceptors.response.use(success=>{
    // 响应成功回调
    if (success.status && success.status == 200 && success.data.status == 500) {
        // 业务错误
        Message.error({message:success.data.msg})
        return ;
    }
    // 返回调用成功的数据
    return success.data;
},error => {
    // 响应失败 3xx，4xx,5xx
    if (error.response.status == 504 && error.response.status == 404) {
        Message.error({message:'服务器被吃了（( ╯□╰ )）'})
    }else if (error.response.status == 403) {
        Message.error({message:'权限不足，请联系管理员'})
    }else if (error.response.status == 401) {
        Message.error({message:'尚未登录，请登录'})
    }else{
        if (error.response.data.msg) {
            Message.error({message:error.response.data.msg})
        }else{
            Message.error({message: '未知错误'})
        }
    }
    return;
})

// 封装post请求
let base = '';          // 请求前缀

export const postKeyValueRequest=(url,params)=>{
    return axios({
        method:'post',
        url:`${base}${url}`,
        data:params,
        transformRequest:[function (data){      // 默认是json格式请求，将参数转换成key-value
            let ret = '';
            for (let i in data) {
                ret+=encodeURIComponent(i)+'='+encodeURIComponent(data[i])+'&'
            }
            return ret;
        }],
        headers:{
            'Content-Type':'application/x-www-form-urlencoded'
        }
    })
}