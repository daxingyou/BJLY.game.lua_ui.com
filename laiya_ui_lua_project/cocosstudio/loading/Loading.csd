<GameFile>
  <PropertyGroup Name="Loading" Type="Layer" ID="b0bc0de3-6884-4aa2-80a5-040cfe65cdb4" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="30" Speed="1.0000">
        <Timeline ActionTag="-717404840" Property="Scale">
          <ScaleFrame FrameIndex="0" Tween="False" X="0.0010" Y="0.0010" />
          <ScaleFrame FrameIndex="10" Tween="False" X="1.0000" Y="1.0000" />
        </Timeline>
        <Timeline ActionTag="471380903" Property="Scale">
          <ScaleFrame FrameIndex="0" Tween="False" X="0.0010" Y="0.0010" />
          <ScaleFrame FrameIndex="20" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
        <Timeline ActionTag="-1663424031" Property="Scale">
          <ScaleFrame FrameIndex="0" Tween="False" X="0.0010" Y="0.0010" />
          <ScaleFrame FrameIndex="30" X="1.0000" Y="1.0000">
            <EasingData Type="0" />
          </ScaleFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="spotAnim" StartIndex="0" EndIndex="40">
          <RenderColor A="255" R="176" G="224" B="230" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Layer" Tag="3" ctype="GameLayerObjectData">
        <Size X="1280.0000" Y="720.0000" />
        <Children>
          <AbstractNodeData Name="m_background" ActionTag="-39940083" Tag="5" IconVisible="False" LeftMargin="-8.2198" RightMargin="8.2197" LeftEage="422" RightEage="422" TopEage="237" BottomEage="237" Scale9OriginX="422" Scale9OriginY="237" Scale9Width="436" Scale9Height="246" ctype="ImageViewObjectData">
            <Size X="1280.0000" Y="720.0000" />
            <Children>
              <AbstractNodeData Name="version_bg" ActionTag="-767095633" Tag="56" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" RightMargin="1121.0000" BottomMargin="688.0000" LeftEage="52" RightEage="52" TopEage="10" BottomEage="10" Scale9OriginX="52" Scale9OriginY="10" Scale9Width="55" Scale9Height="12" ctype="ImageViewObjectData">
                <Size X="159.0000" Y="32.0000" />
                <Children>
                  <AbstractNodeData Name="m_VersionLable" ActionTag="-52370511" Tag="57" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="28.8200" RightMargin="35.1800" TopMargin="4.5000" BottomMargin="4.5000" FontSize="20" LabelText="APP V 1.0.0" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                    <Size X="95.0000" Y="23.0000" />
                    <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                    <Position X="76.3200" Y="16.0000" />
                    <Scale ScaleX="1.0000" ScaleY="1.0000" />
                    <CColor A="255" R="255" G="255" B="255" />
                    <PrePosition X="0.4800" Y="0.5000" />
                    <PreSize X="0.5975" Y="0.7188" />
                    <FontResource Type="Normal" Path="fonts/FangZhengZhunYuan.TTF" Plist="" />
                    <OutlineColor A="255" R="255" G="0" B="0" />
                    <ShadowColor A="255" R="110" G="110" B="110" />
                  </AbstractNodeData>
                </Children>
                <AnchorPoint ScaleY="1.0000" />
                <Position Y="720.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition Y="1.0000" />
                <PreSize X="0.1242" Y="0.0444" />
                <FileData Type="Normal" Path="loading/loading/version_bg.png" Plist="" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="631.7802" Y="360.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.4936" Y="0.5000" />
            <PreSize X="1.0000" Y="1.0000" />
            <FileData Type="Normal" Path="loading/lobbyPic/bg_denglu.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="bg_loading_9" ActionTag="-289616035" Tag="1705" IconVisible="False" PositionPercentXEnabled="True" LeftMargin="258.0000" RightMargin="258.0000" TopMargin="575.0000" BottomMargin="115.0000" ctype="SpriteObjectData">
            <Size X="764.0000" Y="30.0000" />
            <Children>
              <AbstractNodeData Name="LoadingBarCtrl" ActionTag="-1519628756" Tag="1703" IconVisible="False" PercentWidthEnable="True" PercentHeightEnable="True" PercentWidthEnabled="True" PercentHeightEnabled="True" LeftMargin="8.7460" RightMargin="3.2488" TopMargin="5.7756" BottomMargin="5.2254" ProgressInfo="2" ctype="LoadingBarObjectData">
                <Size X="752.0052" Y="18.9990" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="384.7486" Y="14.7249" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5036" Y="0.4908" />
                <PreSize X="0.9843" Y="0.6333" />
                <ImageFileData Type="Normal" Path="loading/lobbyPic/slider_jindutiao.png" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="txt_loading_8" ActionTag="1245278410" Tag="1704" IconVisible="False" LeftMargin="224.2112" RightMargin="344.7888" TopMargin="-35.4500" BottomMargin="41.4500" ctype="SpriteObjectData">
                <Size X="195.0000" Y="24.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="321.7112" Y="53.4500" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4211" Y="1.7817" />
                <PreSize X="0.2552" Y="0.8000" />
                <FileData Type="Normal" Path="loading/lobbyPic/txt_loading.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="m_Lable" ActionTag="1665267022" Tag="9" IconVisible="False" LeftMargin="470.0000" RightMargin="294.0000" TopMargin="-23.4500" BottomMargin="53.4500" FontSize="24" LabelText="" ShadowOffsetX="2.0000" ShadowOffsetY="-2.0000" ctype="TextObjectData">
                <Size X="0.0000" Y="0.0000" />
                <AnchorPoint ScaleY="0.5000" />
                <Position X="470.0000" Y="53.4500" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="246" G="168" B="27" />
                <PrePosition X="0.6152" Y="1.7817" />
                <PreSize X="0.0000" Y="0.0000" />
                <OutlineColor A="255" R="255" G="0" B="0" />
                <ShadowColor A="255" R="110" G="110" B="110" />
              </AbstractNodeData>
              <AbstractNodeData Name="spot_10" ActionTag="-717404840" Tag="1706" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="432.6676" RightMargin="324.3324" TopMargin="-28.8280" BottomMargin="50.8280" ctype="SpriteObjectData">
                <Size X="7.0000" Y="8.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="436.1676" Y="54.8280" />
                <Scale ScaleX="0.0010" ScaleY="0.0010" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5709" Y="1.8276" />
                <PreSize X="0.0092" Y="0.2667" />
                <FileData Type="Normal" Path="loading/lobbyPic/spot.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="spot_10_0" ActionTag="471380903" Tag="1707" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="442.6760" RightMargin="314.3240" TopMargin="-28.8280" BottomMargin="50.8280" ctype="SpriteObjectData">
                <Size X="7.0000" Y="8.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="446.1760" Y="54.8280" />
                <Scale ScaleX="0.0010" ScaleY="0.0010" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5840" Y="1.8276" />
                <PreSize X="0.0092" Y="0.2667" />
                <FileData Type="Normal" Path="loading/lobbyPic/spot.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="spot_10_1" ActionTag="-1663424031" Tag="1708" IconVisible="False" PositionPercentXEnabled="True" PositionPercentYEnabled="True" LeftMargin="452.6844" RightMargin="304.3156" TopMargin="-28.8280" BottomMargin="50.8280" ctype="SpriteObjectData">
                <Size X="7.0000" Y="8.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="456.1844" Y="54.8280" />
                <Scale ScaleX="0.0010" ScaleY="0.0010" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5971" Y="1.8276" />
                <PreSize X="0.0092" Y="0.2667" />
                <FileData Type="Normal" Path="loading/lobbyPic/spot.png" Plist="" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="640.0000" Y="130.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.5000" Y="0.1806" />
            <PreSize X="0.5969" Y="0.0417" />
            <FileData Type="Normal" Path="loading/lobbyPic/bg_loading.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>