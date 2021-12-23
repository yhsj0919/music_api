//使用puppeteer: ^2.0.0实现登录
//2021/3/26已经在windows测试通过，需要安装chrome浏览器
//成功之后能直接获取到cookie
//不支持android，ios，web
//具体参考https://gist.github.com/raphaelsoul/c94e01734696fdbc586ecd2df907e603

// Future<void> login() async {
//   var browser = await puppeteer.launch(
//     headless: false,
//     devTools: false,
//   );
//   var page = await browser.newPage();
//   await page.goto('https://y.qq.com', wait: Until.networkIdle);
//
//   await page.waitForSelector(
//       '#divdialog_0 > div.popup__hd > a > i.popup__icon_close',
//       visible: true,
//       timeout: Duration(milliseconds: 3000));
//
//   try {
//     await page
//         .click('#divdialog_0 > div.popup__hd > a > i.popup__icon_close');
//   } catch (e) {
//     print('错误' + e.toString());
//   }
//
// // 点击导航登录
//   await page.click(
//       'body > div.mod_header > div > div.header__opt > span > a.top_login__link.js_login');
//
//   var frameTips = await page.waitForSelector('#frame_tips');
//   var frame_tips = await frameTips.contentFrame;
//   var ptloginIframe = await frame_tips.waitForSelector('#ptlogin_iframe');
//   var ptlogin_iframe = await ptloginIframe.contentFrame;
//
//   await ptlogin_iframe.waitForSelector(
//     '#switcher_plogin',
//     visible: true,
//     timeout: Duration(milliseconds: 3000),
//   );
//
//   // 切换账户/密码登录方式
//   await ptlogin_iframe.click('#switcher_plogin');
//
//   // 等待表单展现
//
//   await ptlogin_iframe.waitForSelector('#u', visible: true);
//   await ptlogin_iframe.waitForSelector('#p', visible: true);
//   await ptlogin_iframe.waitForSelector('#login_button', visible: true);
//
//   // 登录
//   await ptlogin_iframe.type('#u', '你的账号',
//       delay: Duration(milliseconds: 200));
//   await ptlogin_iframe.type('#p', '你的密码',
//       delay: Duration(milliseconds: 200));
//   await ptlogin_iframe.click('#login_button',
//       delay: Duration(milliseconds: 200));
// // 等待登录完成
//   await page.waitForSelector(
//       'body > div.mod_header > div > div.header__opt > span > a.top_login__link.js_logined');
//
//   var cookies = await page.cookies();
//
//   var cookie = cookies.map((e) => '${e.name}=${e.value}').join(";");
//   print(cookie);
//
//   await browser.close();
// }
