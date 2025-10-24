package pojo;

public class CustomerPojo {

    private static int cid;
    private static int cphone;
    private static String cemail, cname, cpassword;

    public static int getCid() {
        return cid;
    }

    public static void setCid(int cid) {
        CustomerPojo.cid = cid;
    }

    public static int getCphone() {
        return cphone;
    }

    public static void setCphone(int cphone) {
        CustomerPojo.cphone = cphone;
    }

    public static String getCemail() {
        return cemail;
    }

    public static void setCemail(String cemail) {
        CustomerPojo.cemail = cemail;
    }

    public static String getCname() {
        return cname;
    }

    public static void setCname(String cname) {
        CustomerPojo.cname = cname;
    }

    public static String getCpassword() {
        return cpassword;
    }

    public static void setCpassword(String cpassword) {
        CustomerPojo.cpassword = cpassword;
    }
}
