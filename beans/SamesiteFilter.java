package com.csgroup.general;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.SimpleTimeZone;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class for Samesite attribute
 */
@WebFilter("/*")
public class SamesiteFilter implements Filter {
	
	private org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");

	/**
	 * Default constructor.
	 */
	public SamesiteFilter() {
		// TODO Auto-generated constructor stub        
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		// Pass the request along the filter chain
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		boolean isSafariRequest = false;
		boolean isChromeRequest = false;
		String userAgent = httpRequest.getHeader("User-Agent");
                                                                                                                                                                                                                                                                                                                                                                                                                    
		// User agent string for various browsers
		// Safari: Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/534.57.2 (KHTML, like
		// Gecko) Version/5.1.7 Safari/534.57.2
		// Chrome: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML,
		// like Gecko) Chrome/80.0.3987.149 Safari/537.36

		// NOTE: chrome also contains Safari string but we should make sure only for 
		// Safari text
		if (null != userAgent && (userAgent.toLowerCase().indexOf("safari") != -1
				&& userAgent.toLowerCase().indexOf("chrome") == -1)) {
			isSafariRequest = true;	
		}
		
		if ( (!isSafariRequest)  && (null != userAgent && (userAgent.toLowerCase().indexOf("chrome") != -1))) {
			isChromeRequest = true;	
		}
		
		logger.debug("isChromeRequest "+isChromeRequest);
		// Use filter for only Safari
		if (isChromeRequest) {
			HttpSession session = httpRequest.getSession();
			logger.debug("session== "+session);
			if (null != session) {

				Cookie arrayCookies[] = httpRequest.getCookies();
				logger.debug("arrayCookies : " + arrayCookies);
				String previousSessionId = null;
				if (null != arrayCookies) {
					for (Cookie cookie : arrayCookies) {
						
						String cookieName = cookie.getName();
						logger.debug("cookieName " + cookieName + "cookieValue" +
								 cookie.getValue());
						if (cookieName.equalsIgnoreCase("JSESSIONID")) {
							
							previousSessionId = cookie.getValue();
							logger.debug("JSESSIONID cookieName " + cookieName + "cookieValue" +
									 cookie.getValue());
							break;
						}
					}
				}
				logger.debug("Curretnt Session id: " + session.getId());
				String targetSessionId = null;
				if (null == previousSessionId) {
					targetSessionId = session.getId();
				} else {
					targetSessionId = previousSessionId;
				}
				
				httpResponse.setHeader("Set-Cookie", prepareCookie(request.getServerName(), targetSessionId));

			} else {
				logger.debug("Session id: " + null);
			}

		}
		// pass the request along the filter chain
		chain.doFilter(httpRequest, httpResponse);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * 
	 * @param servername
	 * @param targetSessionId
	 * @return
	 */
	private String prepareCookie(String servername, String targetSessionId) {
		
		SimpleDateFormat COOKIE_EXPIRES_HEADER_FORMAT = new SimpleDateFormat("EEE, dd-MMM-yyyy HH:mm:ss zzz");
		COOKIE_EXPIRES_HEADER_FORMAT.setTimeZone(new SimpleTimeZone(0, "GMT"));
		Date d = new Date();
		d.setTime(d.getTime() + 3600 * 1000); //1 hour
		String cookieLifeTime = COOKIE_EXPIRES_HEADER_FORMAT.format(d);
		
				
		Date expdate = new Date ();
		expdate.setTime (expdate.getTime() + (36000000 * 1000));

		//int expiration = 365 * 24 * 60 * 60;
		StringBuilder cookieString = new StringBuilder("JSESSIONID" + "=" + targetSessionId + "; ");
		DateFormat df = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss", Locale.US);
//		Calendar cal = Calendar.getInstance();
//		cal.add(Calendar.SECOND, expdate.toLocaleString());
		//cookieString.append("Expires=" + df.format(expdate) + "; ");
		cookieString.append("Expires=" + cookieLifeTime + "; ");
		cookieString.append("Domain=.c-sgroup.com; ");
		cookieString.append("Path=/; ");
		//cookieString.append("Max-Age=" + df.format(expdate) + "; ");
		cookieString.append("Max-Age=" + cookieLifeTime + "; ");
		cookieString.append("HttpOnly; ");
		cookieString.append("Secure; ");
		// cookieString.append("SameSite=Strict"); 
		// cookieString.append("SameSite=Lax");
		cookieString.append("SameSite=None");
		return cookieString.toString();
	}

}
