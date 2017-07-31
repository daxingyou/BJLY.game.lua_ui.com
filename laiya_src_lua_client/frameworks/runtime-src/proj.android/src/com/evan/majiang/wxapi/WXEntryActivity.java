package com.evan.majiang.wxapi;

import java.io.File;

import com.evan.majiang.AppActivity;
import com.evan.majiang.Constants;
import com.evan.majiang.R;
//import org.cocos2dx.cpp.Native;
import com.base.lua.Util;
import com.evan.majiang.Native;
import com.evan.majiang.wxapi.WXEntryActivity;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.PixelFormat;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.util.Log;

import com.tencent.mm.opensdk.constants.ConstantsAPI;
import com.tencent.mm.opensdk.modelbase.BaseReq;
import com.tencent.mm.opensdk.modelbase.BaseResp;
import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.modelmsg.SendMessageToWX;
import com.tencent.mm.opensdk.modelmsg.WXAppExtendObject;
import com.tencent.mm.opensdk.modelmsg.WXImageObject;
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage;
import com.tencent.mm.opensdk.modelmsg.WXTextObject;
import com.tencent.mm.opensdk.modelmsg.WXWebpageObject;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

public class WXEntryActivity extends Activity implements IWXAPIEventHandler{
	
	public static String Tag = "WXEntryActivity";
	private static final int TIMELINE_SUPPORTED_VERSION = 0x21020001;
	private static WXEntryActivity sContext = null;
	public static boolean bLogonWX = false;
	private static final int THUMB_SIZE = 150;
	private static int share_type = 0;

//	  public static final String APP_ID = "wx9ac9ddb90cdcadb7";//"wx79ad4c77ea07f41e";
//	  public static final String AppSecret = "257306b69877fa65bf2259e4d977bff3";//"66ad79231c6954ba68811afb14fad5e2";
	
    private static IWXAPI 			  api;
    
	private static final int SceneSession = 0;//闁告帒妫旈棅鈺呭礆妫颁胶绐楅悹鍥锋嫹
	private static final int SceneTimeline = 1; //闁告帒妫旈棅鈺呭礆閻�?牊绠欓柛娆忣儏濠��锟��?
	
	public static String ReqWxLogin = "ReqWxLogin";
	public static String ReqWxShareImg = "ReqWxShareImg";
	public static String ReqWxShareTxt = "ReqWxShareTxt";
	public static String ReqWxShareUrl = "ReqWxShareUrl";
	public static String ReqWXPay = "ReqWXPay";
	
	
	
	  @Override
	 public void onCreate(Bundle savedInstanceState)
	 {
	        super.onCreate(savedInstanceState);
	        sContext = this;
    	    Log.d(Tag,"onCreate");
	        
			Intent intent = getIntent();

	    	api = WXAPIFactory.createWXAPI(this,Constants.APP_ID, true);
		    api.registerApp(Constants.APP_ID);
	        api.handleIntent(intent, this);
	        
			if (intent.hasExtra(ReqWxLogin)) 
			{
	        	reqLogin();
			}
			else if(intent.hasExtra(ReqWxShareImg))
			{
				String ImgPath = intent.getStringExtra("ImgPath");
				int nType = intent.getIntExtra("ShareType",0);
				 reqShareImg(ImgPath,nType);
			}
			else if(intent.hasExtra(ReqWxShareTxt))
			{
				String ShareText = intent.getStringExtra("ShareText");
				int nType = intent.getIntExtra("ShareType",0);
				reqShareTxt(ShareText,nType);
			}
			else if(intent.hasExtra(ReqWxShareUrl))
			{
				String ShareUrl = intent.getStringExtra("ShareUrl");
				String ShareTitle = intent.getStringExtra("ShareTitle");
				String ShareDesc = intent.getStringExtra("ShareDesc");
				int nType = intent.getIntExtra("ShareType",0);
				reqShareUrl(ShareUrl,ShareTitle,ShareDesc,nType);
			}
			finish();
	 }
	  
	  @Override
	  protected void onNewIntent(Intent intent) 
	  {
			super.onNewIntent(intent);
			
			setIntent(intent);
			WXEntryActivity.api.handleIntent(intent, this);
	  }
 
    public void reqLogin()
    {
    	SendAuth.Req req = new SendAuth.Req();
    	req.scope = "snsapi_userinfo";
    	req.state = "carjob_wx_login";
    	WXEntryActivity.api.sendReq(req);
	    Log.d(Tag,"reqLogin!!!!");
    } 
    public void reqShareImg(String ImgPath,int nType)
    {
    	
		File file = new File(ImgPath);
		if (!file.exists()) 
		{
		    Log.d(Tag,"reqShare file not exists:"+ImgPath);
		    return;
		}

		Bitmap bmp = BitmapFactory.decodeFile(ImgPath);
		WXImageObject imgObj = new WXImageObject(bmp);
		
		WXMediaMessage msg = new WXMediaMessage();
		msg.mediaObject = imgObj;
		
		Bitmap thumbBmp = Bitmap.createScaledBitmap(bmp, 128, 72, true);
		bmp.recycle();
		msg.thumbData = Util.bmpToByteArray(thumbBmp, true);
		
		SendMessageToWX.Req req = new SendMessageToWX.Req();
		req.transaction = buildTransaction("img");
		req.message = msg;
		if(nType==SceneTimeline )
		{
			share_type = 0;
			req.scene = SendMessageToWX.Req.WXSceneTimeline;
		}
		else if(nType==SceneSession )
		{
			share_type = 1;
			req.scene = SendMessageToWX.Req.WXSceneSession;
		}
		WXEntryActivity.api.sendReq(req);
	    Log.d(Tag,"reqShare Ok:"+ImgPath);
    }
    public void reqShareTxt(String text,int nType)
    {
    	
		// 鍒濆鍖栦竴涓猈XTextObject瀵硅�?
		WXTextObject textObj = new WXTextObject();
		textObj.text = text;

		// 鐢╓XTextObject瀵硅薄鍒濆鍖栦竴涓猈XMediaMessage瀵硅�?
		WXMediaMessage msg = new WXMediaMessage();
		msg.mediaObject = textObj;
		// 鍙戦��佹枃鏈被鍨嬬殑娑堟伅鏃讹紝title瀛楁涓嶈捣浣滅�?
		// msg.title = "Will be ignored";
		msg.description = text;

		// 鏋勯��犱竴涓猂eq
		SendMessageToWX.Req req = new SendMessageToWX.Req();
		req.transaction = buildTransaction("text"); // transaction瀛楁鐢ㄤ簬鍞竴鏍囪瘑涓��涓姹��?
		req.message = msg;
		if(nType==SceneTimeline )
		{
			share_type = 2;
			System.out.println("sss1111"); 
			req.scene = SendMessageToWX.Req.WXSceneTimeline;
			
		}
		else if(nType==SceneSession )
		{
			share_type = 3;
			System.out.println("sss222");
			req.scene = SendMessageToWX.Req.WXSceneSession;
		}
		// 璋冪敤api鎺ュ彛鍙戦��佹暟鎹埌寰�?
		WXEntryActivity.api.sendReq(req);
		

	    Log.d(Tag,"reqShareTxt Ok:"+text);
    }
    
    public void reqShareUrl(String url, String title,String desc,int nType)
    {
		WXWebpageObject textObj = new WXWebpageObject();
		textObj.webpageUrl = url;

		WXMediaMessage msg = new WXMediaMessage(textObj);
		msg.title = title;
		msg.description = desc;
		//Bitmap thumb2 = BitmapFactory.decodeResource(this.getResources(), R.drawable.icon); 
		Bitmap map = drawableToBitmap(this.getResources().getDrawable(R.drawable.icon));
		Bitmap thumb2 =Bitmap.createScaledBitmap(map, 120, 120, true);//压缩Bitmap
        
		//msg.thumbData = Util.bmpToByteArray(thumb2, true);
		msg.thumbData = Util.bitmap2Bytes(thumb2, 32);
		
		SendMessageToWX.Req req = new SendMessageToWX.Req();
		req.transaction = buildTransaction("webpage"); 
		req.message = msg;
		if(nType==SceneTimeline )
		{
			req.scene = SendMessageToWX.Req.WXSceneTimeline;
			share_type = 4;
		}
		else if(nType==SceneSession )
		{
			req.scene = SendMessageToWX.Req.WXSceneSession;
			share_type = 5;
		}
		WXEntryActivity.api.sendReq(req);
	    Log.d(Tag,"reqShareUrl Ok:"+url);
    }

    public void reqShareTxtCB(String text,int nType)
    {
    	share_type = 0;
    	 // send appdata with no attachment
    	WXAppExtendObject appdata = new WXAppExtendObject("lallalallallal", "filePath");
    	
    	boolean bValue =  appdata.checkArgs();
    	if (!bValue)
    	{
    	    Log.d(Tag,"reqShareTxtCB Error:"+text);
    	}
    	
    	WXMediaMessage msg = new WXMediaMessage();
    	msg.title ="11";
    	msg.description = "22";
    	msg.mediaObject = appdata;
    	
    	SendMessageToWX.Req req = new SendMessageToWX.Req();
		req.transaction = buildTransaction("appdata");
		req.message = msg;
		
		if(nType==SceneTimeline )
		{
			share_type = 6;
			req.scene = SendMessageToWX.Req.WXSceneTimeline;
		}
		else if(nType==SceneSession )
		{
			share_type = 7;
			req.scene = SendMessageToWX.Req.WXSceneSession;
		}
		// 璋冪敤api鎺ュ彛鍙戦��佹暟鎹埌寰�?
		WXEntryActivity.api.sendReq(req);

	    Log.d(Tag,"reqShareTxtCB Ok:"+text);
    }
    
	// 鐎甸偊鍣ｉ弫鎾绘嚇濮橆剙娈╅柟椋庡厴閺佹捇寮妶鍡楊伓闂佽法鍠愰弸濠氬箯閻戣姤鏅搁悷妤冨枎閸╁瞼鍠婃径�?�伓闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺��栫��氳鎯旈弮鍫熸櫢闁哄�?�鍊栫��氬綊寮�?崼鏇熸櫢闁哄倶鍊栫��氬綊鏌ㄩ悢鍛婄伄闁圭兘�?遍惃顓㈡煥閻斿憡鐏柟椋庡厴閺佹捇寮妶鍡楊伓婵﹤鎳橀弫鎾诲棘閵堝棗顏堕梺璺ㄥ櫐閹凤拷
	@Override
	public void onReq(BaseReq req) 
	{
		Log.d(Tag,"public void onReq(BaseReq req) !!!!!!!");
		switch (req.getType()) 
		{
		case ConstantsAPI.COMMAND_GETMESSAGE_FROM_WX: 
			Log.d(Tag,"onReq:COMMAND_GETMESSAGE_FROM_WX");
			break;
		case ConstantsAPI.COMMAND_SHOWMESSAGE_FROM_WX:
			Log.d(Tag,"onReq:COMMAND_SHOWMESSAGE_FROM_WX");
			break;
		default:
			break;
		}

	    Log.d(Tag,"onReq:"+req.getType());
	}

	// 闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺��栫��氬綊鏌ㄩ悢鍛婄伄闁瑰嘲鍢茬花鏌ユ煥閻旇櫣鍙撻柛鎴欏��栫��氬綊鏌ㄩ悢鐓庡緧缁炬澘顦扮��氱懓顕ラ锟介弫鎾绘嚇濮橀硸鏆滈柟椋庡厴閺佹捇寮妶鍡楊伓闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺��栫��氬綊鏌ㄩ悢鍛婄伄闁归鍏�?弫鎾诲棘閵堝棗顏堕幖瀛樻閺佹捇寮妶鍡楊伓闂佽法鍠愰弸濠氬箯閻戣姤鏅搁柡鍌樺��栫��氬綊鏌ㄩ悢绋跨劵缁炬澘顦扮��氬綊鏌ㄩ悢鍛婄伄闁归鍏橀弫鎾绘儗椤愩垹娈╅柟椋庡厴閺佹捇寮妶鍡楊伓
	@Override
	public void onResp(BaseResp resp) {
		
		Log.d(Tag,"public void onResp(BaseResp resp)");
		int result = 0;

	    Log.d(Tag,"errCode:"+resp.errCode);
	    
		switch (resp.errCode) {
		case BaseResp.ErrCode.ERR_OK:
		    
		    switch (resp.getType()) {
            case ConstantsAPI.COMMAND_SENDAUTH:
                //登录回调,处理登录成功的逻辑
            	String code = ((SendAuth.Resp) resp).code;
                String Url =code;
                AppActivity.WxLoginCallBack_GetAccessToken(Url);
                break;
            case ConstantsAPI.COMMAND_SENDMESSAGE_TO_WX:
                //分享回调,处理分享成功后的逻辑
            	AppActivity.WxShareCallBack(share_type);
                finish();
                break;
            default:
                break;
        }
		    
			break;
		case BaseResp.ErrCode.ERR_USER_CANCEL:
//		    Native.WxLoginGetAccessToken("ERR_USER_CANCEL");
		    AppActivity.WxLoginCallBack_GetAccessToken("ERR_USER_CANCEL");
			break;
		case BaseResp.ErrCode.ERR_AUTH_DENIED:
//		    Native.WxLoginGetAccessToken("ERR_AUTH_DENIED");
		    AppActivity.WxLoginCallBack_GetAccessToken("ERR_AUTH_DENIED");
			break;
		default:
//		    Native.WxLoginGetAccessToken("REE_Unknow");
		    AppActivity.WxLoginCallBack_GetAccessToken("REE_Unknow");
			break;
		}
	}
	
	private String buildTransaction(final String type) {
		return (type == null) ? String.valueOf(System.currentTimeMillis()) : type + System.currentTimeMillis();
	}
	
	//转化drawableToBitmap 
	public static Bitmap drawableToBitmap(Drawable drawable) 
	{ 
		Bitmap bitmap = Bitmap.createBitmap(drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight(), drawable.getOpacity() != PixelFormat.OPAQUE ? Bitmap.Config.ARGB_8888 : Bitmap.Config.RGB_565); 
		Canvas canvas = new Canvas(bitmap); 
		drawable.setBounds(0, 0, drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight()); 
		drawable.draw(canvas); 
		return bitmap; 
	} 
}
