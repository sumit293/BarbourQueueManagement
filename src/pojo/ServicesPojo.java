package pojo;

public class ServicesPojo {

	static  int sid;
    public static int getsid() {
        return sid;
    }

    public static void setsid(int sid) {
        ServicesPojo.sid = sid;
    }
	public int getSprice() {
		return sprice;
	}
	public void setSprice(int sprice) {
		this.sprice = sprice;
	}
	public static String getSname() {
		return sname;
	}
	public static void setSname(String sname) {
		ServicesPojo.sname = sname;
	}
	public static String getSdesc() {
		return sdesc;
	}
	public static void setSdesc(String sdesc) {
		ServicesPojo.sdesc = sdesc;
	}
	int sprice;
	static String sname,sdesc;
}
