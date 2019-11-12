package com.yz.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import sun.misc.BASE64Encoder;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * @author ZGD
 * @version 创建时间：2019年10月22日 上午10:07:11 类说明：工具类
 */
public class Utils {
	/**
	 * 根据当前日期生成随机ID
	 * 
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月22日上午10:07:58
	 * @return
	 */
	public static String getRandomID() {
		// 当前日期
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String nowDate = sdf.format(new Date());
		// 生成四位随机数
		Random random = new Random();
		String ID = nowDate
				+ String.valueOf(random.nextInt(9999 - 1000 + 1) + 1000);

		return ID;
	}
	
	/**
	 * 根据指定日期生成随机id
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月30日下午3:16:11
	 * @param date
	 * @return
	 */
	public static String getOnlyID(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		if(date == null || "".equals(date)){
			date = sdf.format(new Date());
		}else {
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
			try {
				date = sdf.format(sdf2.parse(date));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// 生成四位随机数
		Random random = new Random();
		String ID = date
				+ String.valueOf(random.nextInt(9999 - 1000 + 1) + 1000);

		return ID;
	}

	/**
	 * 根据生日算年龄
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月22日下午1:40:53
	 * @param birthday 出生日期
	 * @return
	 * @throws ParseException 
	 */
	public static String getAge(String birthday) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// Calendar：日历
		/* 从Calendar对象中或得一个Date对象 */
		Calendar cal = Calendar.getInstance();
		/* 把出生日期放入Calendar类型的bir对象中，进行Calendar和Date类型进行转换 */
		Calendar bir = Calendar.getInstance();
		try {
			bir.setTime(sdf.parse(birthday));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/* 如果生日大于当前日期，则抛出异常：出生日期不能大于当前日期 */
		if (cal.before(birthday)) {
			throw new IllegalArgumentException(
					"The birthday is before Now,It's unbelievable");
		}
		/* 取出当前年月日 */
		int yearNow = cal.get(Calendar.YEAR);
		int monthNow = cal.get(Calendar.MONTH);
		int dayNow = cal.get(Calendar.DAY_OF_MONTH);
		/* 取出出生年月日 */
		int yearBirth = bir.get(Calendar.YEAR);
		int monthBirth = bir.get(Calendar.MONTH);
		int dayBirth = bir.get(Calendar.DAY_OF_MONTH);
		/* 大概年龄是当前年减去出生年 */
		int age = yearNow - yearBirth;
		/* 如果出当前月小与出生月，或者当前月等于出生月但是当前日小于出生日，那么年龄age就减一岁 */
		if (monthNow < monthBirth
				|| (monthNow == monthBirth && dayNow < dayBirth)) {
			age--;
		}
		return String.valueOf(age);
	}
	
	/**
	 * 图片上传到本地
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月22日下午2:37:08
	 * @param file：上传的文件
	 * @param target：保存的路径名
	 * @return
	 */
	public static JSONObject uplodPicture(MultipartFile file, String target){
		
		String originalName = file.getOriginalFilename();
		//生成24位随机uuid
		String uuid = UUID.randomUUID().toString().replace("-", "");
		String[] split = originalName.split("\\.");
		String fileFileName = uuid+"."+split[1];
		//图片存放路径
		String target2 = "D:/myPicture/"+target+"/" + fileFileName;
		// 获得上传的文件
		File targetFile = new File(target2);
		if(!targetFile.getParentFile().exists()){
			targetFile.getParentFile().mkdirs();
        }
		try {
			file.transferTo(targetFile);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		JSONObject json = new JSONObject();

		JSONArray jsonMembers = new JSONArray();

		JSONObject temjoan = new JSONObject();
		temjoan.put("src", target2);

		json.put("code", 0);
		json.put("msg", 0);

		jsonMembers.add(temjoan);
		json.put("data", jsonMembers);
		
		return json;
		
	}
	
	/**
	 * 通过图片存放路径获取图片
	 * @Author 作者: ZhuGuodong
	 * @version 创建时间: 2019年10月27日上午12:44:37
	 * @param path：图片存放路径
	 * @return
	 */
	public static String getPicture(String path){
		byte[] data = null;
		String picture = "";
		if (path != null && !"".equals(path)) {
			File file = new File(path);
			InputStream in = null;
			try {
				in = new FileInputStream(file);
				data = new byte[in.available()];
				in.read(data);
				in.close();
				BASE64Encoder encoder = new BASE64Encoder();
				picture = encoder.encode(data);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return picture;
	}

}
