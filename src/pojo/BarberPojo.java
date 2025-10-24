package pojo;

public class BarberPojo {

	int bid;
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public static String getBname() {
		return bname;
	}
	public static void setBname(String bname) {
		BarberPojo.bname = bname;
	}
	public static String getBemail() {
		return bemail;
	}
	public static void setBemail(String bemail) {
		BarberPojo.bemail = bemail;
	}
	public static String getBpassword() {
		return bpassword;
	}
	public static void setBpassword(String bpassword) {
		BarberPojo.bpassword = bpassword;
	}
	public int getBphone() {
		return bphone;
	}
	public void setBphone(int bphone) {
		this.bphone = bphone;
	}
	static String bname, bemail, bpassword;
	int bphone;
	
}
