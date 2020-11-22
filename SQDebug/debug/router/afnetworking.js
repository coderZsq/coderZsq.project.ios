const path = require('path');

const Router = require('koa-router');
const send = require('koa-send');
const multer = require('koa-multer');

const router = new Router({ prefix: '/afn' });

router.get('/downloadTask/:name', async (ctx, next) => {
  const name = ctx.params.name;
  console.log(name)
  const path = `uploads/${name}`;
  ctx.attachment(path);
  await send(ctx, path);
});

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({
  storage
});

router.post('/uploadTask/upload', upload.single('file'), (ctx, next) => {
  console.log(ctx.req.file);
  ctx.response.body = {
    msg: 'upload success!'
  };
});

router.get('/dataTask/get', (ctx, next) => {
  ctx.status = 200;
  ctx.body = {
    msg: 'get success!'
  }
});

module.exports = router;