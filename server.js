const koa = require('koa');
const serve = require('koa-static');

const app = koa();
app.use(serve(`${__dirname}/public`));

app.listen(4000, (err) => {
  if (err) {
    throw err;
  }
  console.log(`Started on http://localhost:${4000}`);
});
