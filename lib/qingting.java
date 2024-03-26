//import javax.crypto.Mac;
//import javax.crypto.SecretKey;
//import javax.crypto.spec.SecretKeySpec;
//import java.security.InvalidKeyException;
//import java.security.NoSuchAlgorithmException;
//import java.time.LocalDateTime;
//import java.time.ZoneId;
//import java.time.temporal.ChronoUnit;
//
//public class Test {
//    static private Mac hMac;
//
//    public static String getURLById(int id) {
//        try {
//            hMac = Mac.getInstance("HmacMD5");
//            SecretKey secretKey = new SecretKeySpec("Lwrpu$K5oP".getBytes(), "HmacMD5");
//            hMac.init(secretKey);
//        } catch (NoSuchAlgorithmException | InvalidKeyException ignored) {
//        }
//
//        LocalDateTime localDateTime = LocalDateTime.now().plus(1, ChronoUnit.HOURS);
//        String t = "/live/" + id + "/64k.mp3";
//        //小写
//        String n = Long.toHexString(localDateTime.atZone(ZoneId.systemDefault()).toEpochSecond()).toLowerCase();
//        String r = "web";
//        //手动URLEncode
//        String i = t.replaceAll("/", "%2F");
//        String a = "app_id=" + r + "&path=" + i + "&ts=" + n;
//        //hMacMd5
//        hMac.update(a.getBytes());
//        String o = byte2HexString(hMac.doFinal());
//        return "https://lhttp.qingting.fm" + t + "?app_id=" + r + "&ts=" + n + "&sign=" + o;
//    }
//
//    public static String byte2HexString(final byte[] data) {
//        final int l = data.length;
//        final char[] out = new char[l << 1];
//        // two characters form the hex value.
//        for (int i = 0, j = 0; i < l; i++) {
//            out[j++] = DIGITS_LOWER[(0xF0 & data[i]) >>> 4];
//            out[j++] = DIGITS_LOWER[0x0F & data[i]];
//        }
//        return new String(out);
//    }
//
//    public static final char[] DIGITS_LOWER = {'0', '1', '2', '3', '4', '5',
//            '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
//
//    public static void main(String[] args) {
//        String url = getURLById(1671);
//        System.out.println(url);
//    }
//}
