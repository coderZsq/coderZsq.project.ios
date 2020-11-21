const Koa = require('koa');
const bodyParser = require('koa-bodyparser');
const userRouter = require('./router/afnetworking');

const app = new Koa();

app.use(bodyParser());
app.use(userRouter.routes());
app.use(userRouter.allowedMethods());

app.listen('8080', () => {
  console.log('服务器启动成功');
});