function h(t, e) {
    if (null == e || e.length <= 0)
        return console.log("Please enter a password with which to encrypt the message."),
            null;
    for (var n = "", i = 0; i < e.length; i++)
        n += e.charCodeAt(i).toString();
    const r = Math.floor(n.length / 5)
        , o = parseInt(n.charAt(r) + n.charAt(2 * r) + n.charAt(3 * r) + n.charAt(4 * r) + n.charAt(5 * r))
        , l = Math.ceil(e.length / 2)
        , c = Math.pow(2, 31) - 1;
    if (o < 2)
        return console.log("Algorithm cannot find a suitable hash. Please choose a different password. \nPossible considerations are to choose a more complex or longer password."),
            null;
    let d = Math.round(1e9 * Math.random()) % 1e8;
    for (n += d; n.length > 10;)
        console.log(n.substring(0, 10)),
        console.log(n.substring(10, n.length)),
        n = (parseInt(n.substring(0, 10)) + parseInt(n.substring(10, n.length))).toString();
        console.log(n),
    n = (o * n + l) % c;
    console.log(n)
    let h = "", f = "";
    for (i = 0; i < t.length; i++)
        f += (h = parseInt(t.charCodeAt(i) ^ Math.floor(n / c * 255))) < 16 ? "0" + h.toString(16) : h.toString(16),
            n = (o * n + l) % c;
    for (d = d.toString(16); d.length < 8;)
        d = "0" + d;

    let dd = f += d
    return dd
}

//手机网页的算法
function l(s) {

    return y(d(m(s), 8 * s.length))
}
function d(t, e) {
    t[e >> 5] |= 128 << 24 - e % 32,
        t[15 + (e + 64 >> 9 << 4)] = e;
    for (var n = Array(80), a = 1732584193, b = -271733879, o = -1732584194, r = 271733878, c = -1009589776, i = 0; i < t.length; i += 16) {
        for (var l = a, d = b, m = o, y = r, x = c, k = 0; k < 80; k++) {
            n[k] = k < 16 ? t[i + k] : h(n[k - 3] ^ n[k - 8] ^ n[k - 14] ^ n[k - 16], 1);
            var C = v(v(h(a, 5), f(k, b, o, r)), v(v(c, n[k]), w(k)));
            c = r,
                r = o,
                o = h(b, 30),
                b = a,
                a = C
        }
        a = v(a, l),
            b = v(b, d),
            o = v(o, m),
            r = v(r, y),
            c = v(c, x)
    }
    return Array(a, b, o, r, c)
}
function f(t, b, e, n) {
    return t < 20 ? b & e | ~b & n : t < 40 ? b ^ e ^ n : t < 60 ? b & e | b & n | e & n : b ^ e ^ n
}
function w(t) {
    return t < 20 ? 1518500249 : t < 40 ? 1859775393 : t < 60 ? -1894007588 : -899497514
}
function v(t, e) {
    var n = (65535 & t) + (65535 & e);
    return (t >> 16) + (e >> 16) + (n >> 16) << 16 | 65535 & n
}
function h(t, e) {
    return t << e | t >>> 32 - e
}
function m(t) {
    for (var e = Array(), i = 0; i < 8 * t.length; i += 8)
        e[i >> 5] |= (255 & t.charCodeAt(i / 8)) << 24 - i % 32;
    return e
}
function y(t) {
    for (var e = "0123456789abcdef", n = "", i = 0; i < 4 * t.length; i++)
        n += e.charAt(t[i >> 2] >> 8 * (3 - i % 4) + 4 & 15) + e.charAt(t[i >> 2] >> 8 * (3 - i % 4) & 15);
    return n
}



console.log(l("Dy5ceMTwPFsnQKj5FTdEZZTyatsj46Na"))