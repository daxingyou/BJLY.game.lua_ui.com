local m = {}
local _n = {}

m.shareType = {
	friendCircle = 1,
	friendQun = 0,
}

_n.loginWeiXinSig = {
	javaClassName = "com/base/lua/WXHelper",
	javaMethodName = "LoginWX",
	javaMethodSig = "()V",
}
function m:loginWeiXin()
	local args = {}
    if "ios" == device.platform then
    elseif "android" == device.platform then
		local ok,res = luaj.callStaticMethod(_n.loginWeiXinSig.javaClassName,_n.loginWeiXinSig.javaMethodName,args,_n.loginWeiXinSig.javaMethodSig)
		print("-----loginWeiXin-----",ok,res)
		return ok	
    elseif "windows" == device.platform then
    
    end
end

_n.shareImageWXSig = {
	javaClassName = "com/base/lua/WXHelper",
	javaMethodName = "ShareImageWX",
	javaMethodSig = "(Ljava/lang/String;I)V",
}
function m:shareImageWX(_imgPath,_type)
	local args = {_imgPath,_type}
    if "ios" == device.platform then
    elseif "android" == device.platform then
		local ok,res = luaj.callStaticMethod(_n.shareImageWXSig.javaClassName,_n.shareImageWXSig.javaMethodName,args,_n.shareImageWXSig.javaMethodSig)
		print("-----shareImageWX-----",ok,res)
		return ok	
    elseif "windows" == device.platform then
    
    end
end

_n.shareTextWXSig = {
	javaClassName = "com/base/lua/WXHelper",
	javaMethodName = "ShareTextWX",
	javaMethodSig = "(Ljava/lang/String;I)V",
}
function m:shareTextWX(_txt,_type)
	local args = {_txt,_type}
    if "ios" == device.platform then
    elseif "android" == device.platform then
		local ok,res = luaj.callStaticMethod(_n.shareTextWXSig.javaClassName,_n.shareTextWXSig.javaMethodName,args,_n.shareTextWXSig.javaMethodSig)
		print("-----loginWeiXin-----",ok,res)
		return ok	
    elseif "windows" == device.platform then
    
    end
end

_n.shareUrlWXSig = {
	javaClassName = "com/base/lua/WXHelper",
	javaMethodName = "ShareUrlWX",
	javaMethodSig = "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V",
}
function m:shareUrlWX(url,title,desc,_type)
	local args = {url,title,desc,_type}
    if "ios" == device.platform then
    elseif "android" == device.platform then
		local ok,res = luaj.callStaticMethod(_n.shareUrlWXSig.javaClassName,_n.shareUrlWXSig.javaMethodName,args,_n.shareUrlWXSig.javaMethodSig)
		print("-----shareUrlWX-----",ok,res)
		return ok	
    elseif "windows" == device.platform then
    
    end
end


return m
