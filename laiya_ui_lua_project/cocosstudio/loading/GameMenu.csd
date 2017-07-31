<GameFile>
  <PropertyGroup Name="GameMenu" Type="Layer" ID="dc38688c-b51f-4675-a29e-fa73cbce65b4" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="50" Speed="1.0000" ActivedAnimationName="anim_gift">
        <Timeline ActionTag="1474240108" Property="Scale">
          <ScaleFrame FrameIndex="0" X="0.5000" Y="0.5000">
            <EasingData Type="1" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="25" X="1.0000" Y="1.0000">
            <EasingData Type="4" />
          </ScaleFrame>
          <ScaleFrame FrameIndex="50" X="0.5000" Y="0.5000">
            <EasingData Type="-1">
              <Points>
                <PointF />
                <PointF Y="0.9800" />
                <PointF X="1.0000" />
                <PointF X="1.0000" Y="1.0000" />
              </Points>
            </EasingData>
          </ScaleFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="anim_gift" StartIndex="0" EndIndex="50">
          <RenderColor A="255" R="238" G="232" B="170" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Layer" Tag="13" ctype="GameLayerObjectData">
        <Size X="1280.0000" Y="720.0000" />
        <Children>
          <AbstractNodeData Name="bg_index_1" ActionTag="-692434985" Tag="1017" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" ctype="SpriteObjectData">
            <Size X="1280.0000" Y="720.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <FileData Type="Normal" Path="loading/lobbyPic/bg_index.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
          <AbstractNodeData Name="slogan_1" ActionTag="-163276186" Tag="91" IconVisible="False" LeftMargin="532.0001" RightMargin="531.9999" TopMargin="9.2613" BottomMargin="567.7387" ctype="SpriteObjectData">
            <Size X="216.0000" Y="143.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0001" Y="639.2387" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.8878" />
            <PreSize X="0.1688" Y="0.1986" />
            <FileData Type="Normal" Path="loading/lobbyPic/slogan.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
          <AbstractNodeData Name="headInfoSet" ActionTag="-1398898539" Tag="1358" IconVisible="False" LeftMargin="140.6033" RightMargin="819.3967" TopMargin="18.0940" BottomMargin="586.9060" ctype="SpriteObjectData">
            <Size X="320.0000" Y="115.0000" />
            <Children>
              <AbstractNodeData Name="btn_addCard" ActionTag="-2089014592" Tag="1356" IconVisible="False" LeftMargin="177.1884" RightMargin="105.8116" TopMargin="71.0616" BottomMargin="5.9384" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="8" Scale9Height="17" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="37.0000" Y="38.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="195.6884" Y="24.9384" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.6115" Y="0.2169" />
                <PreSize X="0.1156" Y="0.3304" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
                <PressedFileData Type="Normal" Path="loading/lobbyPic/bg_add_down.png" Plist="" />
                <NormalFileData Type="Normal" Path="loading/lobbyPic/bg_add.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="img_click" ActionTag="9157909" Tag="320" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="17.0080" RightMargin="82.9920" TopMargin="36.4980" BottomMargin="-1.4980" TouchEnable="True" LeftEage="9" RightEage="9" TopEage="9" BottomEage="9" Scale9OriginX="9" Scale9OriginY="9" Scale9Width="12" Scale9Height="12" ctype="ImageViewObjectData">
                <Size X="220.0000" Y="80.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="127.0080" Y="38.5020" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3969" Y="0.3348" />
                <PreSize X="0.6875" Y="0.6957" />
                <FileData Type="Normal" Path="loading/lobbyPic/img_transparent.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="iv_click" ActionTag="-1565074970" Tag="79" IconVisible="False" LeftMargin="12.9795" RightMargin="87.0205" TopMargin="26.3258" BottomMargin="-1.3258" TouchEnable="True" LeftEage="9" RightEage="9" TopEage="9" BottomEage="9" Scale9OriginX="9" Scale9OriginY="9" Scale9Width="12" Scale9Height="12" ctype="ImageViewObjectData">
                <Size X="220.0000" Y="90.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="122.9795" Y="43.6742" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.3843" Y="0.3798" />
                <PreSize X="0.6875" Y="0.7826" />
                <FileData Type="Normal" Path="loading/lobbyPic/img_transparent.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="icon_fangka_7" ActionTag="1164841833" Tag="1355" IconVisible="False" LeftMargin="30.9591" RightMargin="239.0409" TopMargin="73.0616" BottomMargin="2.9384" ctype="SpriteObjectData">
                <Size X="50.0000" Y="39.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="55.9591" Y="22.4384" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1749" Y="0.1951" />
                <PreSize X="0.1563" Y="0.3391" />
                <FileData Type="Normal" Path="loading/lobbyPic/icon_fangka.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="goldNum" ActionTag="907123444" Tag="1357" IconVisible="False" LeftMargin="83.4027" RightMargin="197.5973" TopMargin="76.5600" BottomMargin="9.4400" FontSize="26" LabelText="123" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="39.0000" Y="29.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="83.4027" Y="23.9400" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="247" G="212" B="106" />
                <PrePosition X="0.2606" Y="0.2082" />
                <PreSize X="0.1219" Y="0.2522" />
                <FontResource Type="Normal" Path="fonts/FangZhengZhunYuan.TTF" Plist="" />
                <OutlineColor A="255" R="255" G="255" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="userId" ActionTag="-2137273215" Tag="20" IconVisible="False" LeftMargin="37.0490" RightMargin="132.9510" TopMargin="38.9063" BottomMargin="47.0937" FontSize="26" LabelText="ID:123456789" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="150.0000" Y="29.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="37.0490" Y="61.5937" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="247" G="212" B="106" />
                <PrePosition X="0.1158" Y="0.5356" />
                <PreSize X="0.4688" Y="0.2522" />
                <FontResource Type="Normal" Path="fonts/FangZhengZhunYuan.TTF" Plist="" />
                <OutlineColor A="255" R="255" G="165" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="nickName" ActionTag="-472292975" Tag="19" IconVisible="False" LeftMargin="34.2292" RightMargin="226.7708" TopMargin="4.2284" BottomMargin="78.7716" FontSize="28" LabelText="朱锋" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="59.0000" Y="32.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="34.2292" Y="94.7716" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="247" G="212" B="106" />
                <PrePosition X="0.1070" Y="0.8241" />
                <PreSize X="0.1844" Y="0.2783" />
                <FontResource Type="Normal" Path="fonts/FangZhengZhunYuan.TTF" Plist="" />
                <OutlineColor A="255" R="255" G="165" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="headIcon" ActionTag="-1744351602" Tag="18" IconVisible="False" PositionPercentYEnabled="True" LeftMargin="-111.2301" RightMargin="326.2301" TopMargin="3.9995" BottomMargin="6.0005" ctype="SpriteObjectData">
                <Size X="105.0000" Y="105.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-58.7301" Y="58.5005" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="-0.1835" Y="0.5087" />
                <PreSize X="0.3281" Y="0.9130" />
                <FileData Type="Normal" Path="loading/lobbyPic/default_head.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="btn_head_frame" ActionTag="1044867834" CallBackType="Touch" Tag="164" IconVisible="False" LeftMargin="-121.6852" RightMargin="315.6852" TopMargin="-6.7771" BottomMargin="-2.2229" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="96" Scale9Height="102" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
                <Size X="126.0000" Y="124.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="-58.6852" Y="59.7771" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="-0.1834" Y="0.5198" />
                <PreSize X="0.3938" Y="1.0783" />
                <TextColor A="255" R="65" G="65" B="70" />
                <DisabledFileData Type="Normal" Path="loading/lobbyPic/frame_head.png" Plist="" />
                <PressedFileData Type="Normal" Path="loading/lobbyPic/frame_head.png" Plist="" />
                <NormalFileData Type="Normal" Path="loading/lobbyPic/frame_head.png" Plist="" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="300.6033" Y="644.4060" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.2348" Y="0.8950" />
            <PreSize X="0.2500" Y="0.1597" />
            <FileData Type="Normal" Path="loading/lobbyPic/bg_nameID.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
          <AbstractNodeData Name="panelNotice" ActionTag="-372957284" Tag="35" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="154.5000" RightMargin="154.5000" TopMargin="164.5398" BottomMargin="514.4602" TouchEnable="True" ClipAble="True" BackColorAlpha="0" ComboBoxIndex="1" ColorAngle="90.0000" Scale9Width="1" Scale9Height="1" ctype="PanelObjectData">
            <Size X="971.0000" Y="41.0000" />
            <Children>
              <AbstractNodeData Name="noticeBg" ActionTag="1750655601" Tag="33" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="0.0004" RightMargin="-0.0004" TopMargin="1.0000" BottomMargin="1.0000" ctype="SpriteObjectData">
                <Size X="971.0000" Y="39.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="485.5004" Y="20.5000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.5000" />
                <PreSize X="1.0000" Y="0.9512" />
                <FileData Type="Normal" Path="loading/lobbyPic/bg_tongzhi.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="Text_notice" ActionTag="1040806148" Tag="286" IconVisible="False" LeftMargin="1100.6522" RightMargin="-1189.6523" TopMargin="2.5000" BottomMargin="1.5000" FontSize="32" LabelText="欢迎进入百乐麻将,新手免费领取8张房卡 欢迎关注官方微信：123445556。" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="1060.0000" Y="37.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="1100.6522" Y="20.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="247" G="212" B="106" />
                <PrePosition X="1.1335" Y="0.4878" />
                <PreSize X="1.0917" Y="0.9024" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="534.9602" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.7430" />
            <PreSize X="0.7586" Y="0.0569" />
            <SingleColor A="255" R="150" G="200" B="255" />
            <FirstColor A="255" R="150" G="200" B="255" />
            <EndColor A="255" R="255" G="255" B="255" />
            <ColorVector ScaleY="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="Sprite_9" ActionTag="-237301102" Tag="2065" IconVisible="False" LeftMargin="115.2712" RightMargin="1112.7288" TopMargin="160.1339" BottomMargin="507.8661" ctype="SpriteObjectData">
            <Size X="52.0000" Y="52.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="141.2712" Y="533.8661" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.1104" Y="0.7415" />
            <PreSize X="0.0406" Y="0.0722" />
            <FileData Type="Normal" Path="loading/lobbyPic/icon_laba.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
          <AbstractNodeData Name="btnBackRoom" ActionTag="-1757844882" VisibleForFrame="False" Tag="38" IconVisible="False" LeftMargin="877.1100" RightMargin="84.8900" TopMargin="233.1100" BottomMargin="91.8900" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="288" Scale9Height="373" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="318.0000" Y="395.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="1036.1100" Y="289.3900" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.8095" Y="0.4019" />
            <PreSize X="0.2484" Y="0.5486" />
            <TextColor A="255" R="65" G="65" B="70" />
            <NormalFileData Type="Normal" Path="loading/gamemenu/dd1.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="btnSet" ActionTag="1516855145" Tag="1018" IconVisible="False" LeftMargin="1160.5424" RightMargin="19.4576" TopMargin="12.5692" BottomMargin="605.4308" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="70" Scale9Height="80" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="100.0000" Y="102.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="1210.5424" Y="656.4308" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.9457" Y="0.9117" />
            <PreSize X="0.0781" Y="0.1417" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="loading/lobbyPic/icon_set_down.png" Plist="" />
            <NormalFileData Type="Normal" Path="loading/lobbyPic/icon_set.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="btn_msg" ActionTag="180111037" Tag="1019" IconVisible="False" LeftMargin="1033.1790" RightMargin="146.8210" TopMargin="12.5692" BottomMargin="605.4308" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="70" Scale9Height="80" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="100.0000" Y="102.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="1083.1790" Y="656.4308" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.8462" Y="0.9117" />
            <PreSize X="0.0781" Y="0.1417" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="loading/lobbyPic/icon_message_down.png" Plist="" />
            <NormalFileData Type="Normal" Path="loading/lobbyPic/icon_message.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="btnShareCircle" ActionTag="-1245493952" Tag="1020" IconVisible="False" LeftMargin="905.8180" RightMargin="274.1820" TopMargin="12.5692" BottomMargin="605.4308" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="70" Scale9Height="80" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="100.0000" Y="102.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="955.8180" Y="656.4308" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.7467" Y="0.9117" />
            <PreSize X="0.0781" Y="0.1417" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="loading/lobbyPic/icon_share_down.png" Plist="" />
            <NormalFileData Type="Normal" Path="loading/lobbyPic/icon_share.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="btnJoinRoom" ActionTag="1020963682" Tag="1021" IconVisible="False" LeftMargin="867.5422" RightMargin="60.4578" TopMargin="237.6761" BottomMargin="178.3239" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="322" Scale9Height="282" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="352.0000" Y="304.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="1043.5422" Y="330.3239" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.8153" Y="0.4588" />
            <PreSize X="0.2750" Y="0.4222" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="loading/lobbyPic/button_join_down.png" Plist="" />
            <NormalFileData Type="Normal" Path="loading/lobbyPic/button_join.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="btnCreateRoom" ActionTag="911174125" Tag="1022" IconVisible="False" LeftMargin="416.8724" RightMargin="511.1276" TopMargin="237.6761" BottomMargin="178.3239" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="322" Scale9Height="282" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="352.0000" Y="304.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="592.8724" Y="330.3239" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.4632" Y="0.4588" />
            <PreSize X="0.2750" Y="0.4222" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="loading/lobbyPic/button_found_down.png" Plist="" />
            <NormalFileData Type="Normal" Path="loading/lobbyPic/button_found.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="btnHelp" ActionTag="-1985880740" Tag="1031" IconVisible="False" HorizontalEdge="RightEdge" LeftMargin="385.1040" RightMargin="787.8960" TopMargin="601.9934" BottomMargin="11.0066" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="77" Scale9Height="85" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="107.0000" Y="107.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="438.6040" Y="64.5066" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.3427" Y="0.0896" />
            <PreSize X="0.0836" Y="0.1486" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="loading/lobbyPic/icon_wanfa_down.png" Plist="" />
            <NormalFileData Type="Normal" Path="loading/lobbyPic/icon_wanfa.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="btnAchievement" ActionTag="535962118" Tag="1302" IconVisible="False" HorizontalEdge="RightEdge" VerticalEdge="TopEdge" LeftMargin="774.4260" RightMargin="398.5740" TopMargin="601.9934" BottomMargin="11.0066" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="77" Scale9Height="85" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="107.0000" Y="107.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="827.9260" Y="64.5066" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.6468" Y="0.0896" />
            <PreSize X="0.0836" Y="0.1486" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="loading/lobbyPic/icon_zhanji_down.png" Plist="" />
            <NormalFileData Type="Normal" Path="loading/lobbyPic/icon_zhanji.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="btn_feedback" ActionTag="-1497193479" Tag="1348" IconVisible="False" HorizontalEdge="BothEdge" VerticalEdge="BothEdge" LeftMargin="969.0920" RightMargin="203.9080" TopMargin="601.9880" BottomMargin="11.0120" TouchEnable="True" FontSize="14" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="77" Scale9Height="85" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="107.0000" Y="107.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="1022.5920" Y="64.5120" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.7989" Y="0.0896" />
            <PreSize X="0.0836" Y="0.1486" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="loading/lobbyPic/icon_fankui_down.png" Plist="" />
            <NormalFileData Type="Normal" Path="loading/lobbyPic/icon_fankui.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="btn_activity" ActionTag="-408468709" Tag="1349" IconVisible="False" VerticalEdge="TopEdge" LeftMargin="579.7650" RightMargin="593.2350" TopMargin="601.9934" BottomMargin="11.0066" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="77" Scale9Height="85" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="107.0000" Y="107.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="633.2650" Y="64.5066" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="229" G="229" B="229" />
            <PrePosition X="0.4947" Y="0.0896" />
            <PreSize X="0.0836" Y="0.1486" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="loading/lobbyPic/icon_activity_down.png" Plist="" />
            <NormalFileData Type="Normal" Path="loading/lobbyPic/icon_activity.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="btn_binding" ActionTag="-989125047" Tag="1350" IconVisible="False" LeftMargin="190.4432" RightMargin="982.5568" TopMargin="601.9934" BottomMargin="11.0066" TouchEnable="True" FontSize="14" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="77" Scale9Height="85" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="ButtonObjectData">
            <Size X="107.0000" Y="107.0000" />
            <Children>
              <AbstractNodeData Name="tip_gift" ActionTag="1474240108" Tag="126" IconVisible="False" LeftMargin="-25.0964" RightMargin="59.0964" TopMargin="-17.3559" BottomMargin="71.3559" ctype="SpriteObjectData">
                <Size X="73.0000" Y="53.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="11.4036" Y="97.8559" />
                <Scale ScaleX="0.7408" ScaleY="0.7408" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.1066" Y="0.9145" />
                <PreSize X="0.6822" Y="0.4953" />
                <FileData Type="Normal" Path="loading/lobbyPic/tip_youli.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="243.9432" Y="64.5066" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.1906" Y="0.0896" />
            <PreSize X="0.0836" Y="0.1486" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Normal" Path="loading/lobbyPic/icon_bangding_down.png" Plist="" />
            <NormalFileData Type="Normal" Path="loading/lobbyPic/icon_bangding.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="110" G="110" B="110" />
          </AbstractNodeData>
          <AbstractNodeData Name="bg_advertisment_3" ActionTag="-1016242195" Tag="1352" IconVisible="False" LeftMargin="39.6791" RightMargin="935.3209" TopMargin="220.6765" BottomMargin="154.3235" ctype="SpriteObjectData">
            <Size X="305.0000" Y="345.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="192.1791" Y="326.8235" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.1501" Y="0.4539" />
            <PreSize X="0.2383" Y="0.4792" />
            <FileData Type="Normal" Path="loading/lobbyPic/bg_advertisment.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>