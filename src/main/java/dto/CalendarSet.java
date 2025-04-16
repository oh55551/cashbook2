package dto;
import java.util.*;
import java.sql.*;

public class CalendarSet {
	public static HashMap<String, Integer> getCalendar(int year, int month){
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DATE, 1);
		cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month); // month: 0~11
        if (month == -1) {
    	    month = 11;
    	    year--;
    	} else if (month == 12) {
    	    month = 0;
    	    year++;
    	}
        
        int lastDate = cal.getActualMaximum(Calendar.DATE); 
        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); 
		
        // 출력에 필요한 데이터
		int startBlank = dayOfWeek - 1;
		int endBlank = 0;
		int totalcell = startBlank + lastDate + endBlank;
		
		//totalcell이 7로 나눠 떨어지지않는다면 endblank가 더 필요하다.
		if(totalcell % 7 !=0){
			endBlank = 7-(totalcell % 7);
		// 변경된 endBlank로 다시 totalCell을 계산
			totalcell = startBlank + lastDate + endBlank;
		}

		HashMap<String, Integer> result = new HashMap<>();
			result.put("year", year);
			result.put("month", month);
	        result.put("startBlank", startBlank);
	        result.put("lastDate", lastDate);
	        result.put("endBlank", endBlank);
	        result.put("totalCell", startBlank + lastDate + endBlank);
	    return result;
	}
}
