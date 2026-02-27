within hvac_storage_building.Controls;
model hvac_storage_controller
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput HPMode
    annotation (Placement(transformation(extent={{102,-72},{142,-32}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput systemCommand
    "0 = do nothing; 1=baseline; 2=charge hot; 3=charge cold; 4 = discharge"
    annotation (Placement(transformation(extent={{-140,58},{-100,98}})));
  Modelica.Blocks.Tables.CombiTable1Ds equipmentControl(table=[0,0,0,0,0,273.15
         + 20,1,0; 1,0,0,1,1,273.15 + 48,1,1; 2,-1,0,1,0,273.15 + 55,1,1; 3,1,0,
        0,1,273.15 + 48,1,0; 4,-0.5,0,1,0.5,273.15 + 55,1,1; 5,0,1,1,1,273.15
         + 11,0,1; 6,0,1,1,0,273.15 + 8,0,1; 7,0,1,0,1,273.15 + 11,0,0; 8,0,1,1,
        0.5,273.15 + 8,0,1],                               extrapolation=
        Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    annotation (Placement(transformation(extent={{46,20},{66,40}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{-74,44},{-54,64}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr2(t=0.5)
    annotation (Placement(transformation(extent={{54,-42},{74,-22}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput tesHotStatus
    "-1 = fully discharged, 1 = fully charged, 0 = neither fully charged nor fully discharged"
    annotation (Placement(transformation(extent={{-142,-44},{-102,-4}})));
  Modelica.Blocks.Tables.CombiTable2Ds systemModePre(table=[-999,-1,0,1; 0,0,0,
        0; 1,5,0,1; 2,2,2,4; 3,8,6,6; 4,7,0,3],
                extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    "0=do nothing; 1=chiller serves load; 2=chiller charge tes; 3= tes serves load; 4=hybrid charge; 5=hybrid serves"
    annotation (Placement(transformation(extent={{-30,36},{-10,56}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput loadRequest
    "1=heating; 0=deadband; -1=cooling"
    annotation (Placement(transformation(origin = {0, -12}, extent = {{-140, 18}, {-100, 58}}), iconTransformation(extent = {{-140, 18}, {-100, 58}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea1
    annotation (Placement(transformation(extent={{-78,-70},{-58,-50}})));
  Modelica.Blocks.Tables.CombiTable2Ds tesStatusTable(table=[-999,-1,0,1; -1,-4,
        -3,-2; 0,-1,0,1; 1,2,3,4], extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    annotation (Placement(transformation(extent={{-26,-56},{-6,-36}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput systemMode
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,120})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput HPOnOff
    annotation (Placement(transformation(extent={{100,-102},{140,-62}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr3(t=0.5)
    annotation (Placement(transformation(extent={{60,-96},{80,-76}})));
 Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea2 annotation(
    Placement(transformation(origin = {8, -48}, extent = {{-74, 44}, {-54, 64}})));
  Modelica.Blocks.Tables.CombiTable2Ds systemModeFinal(table=[-999,-4,-3,-2,-1,
        0,1,2,3,4; 0,0,0,0,0,0,0,0,0,0; 1,1,1,1,1,1,1,1,1,1; 2,2,2,2,2,2,2,0,0,
        0; 3,1,1,1,3,3,3,3,3,3; 4,4,4,4,4,4,4,1,1,1; 5,5,5,5,5,5,5,5,5,5; 6,6,6,
        0,6,6,0,6,6,0; 7,5,7,7,5,7,7,5,7,7; 8,8,8,5,8,8,5,8,8,5], extrapolation
      =Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    "0=do nothing; 1=chiller serves load; 2=chiller charge tes; 3= tes serves load; 4=hybrid charge; 5=hybrid serves"
    annotation (Placement(transformation(extent={{10,-24},{30,-4}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput tesColdStatus
    "-1 = fully discharged, 1 = fully charged, 0 = neither fully charged nor fully discharged"
    annotation (Placement(transformation(extent={{-140,-102},{-100,-62}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea3
    annotation (Placement(transformation(extent={{-70,-104},{-50,-84}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput HotTesValve
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,106})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput ColdTesValve annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,80})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput LoadSidePumpFraction
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,24})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput HeatPumpSidePumpFraction
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,56})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput HeatPumpSetpoint annotation
    (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-10})));
equation
  connect(systemCommand, intToRea.u) annotation(
    Line(points = {{-120, 78}, {-86, 78}, {-86, 54}, {-76, 54}}, color = {255, 127, 0}));
  connect(tesHotStatus, intToRea1.u) annotation (Line(points={{-122,-24},{-90,-24},
          {-90,-60},{-80,-60}}, color={255,127,0}));
  connect(greThr2.y, HPMode) annotation (Line(points={{76,-32},{96,-32},{96,-52},
          {122,-52}}, color={255,0,255}));
  connect(greThr3.y, HPOnOff) annotation (Line(points={{82,-86},{94,-86},{94,-82},
          {120,-82}}, color={255,0,255}));
 connect(loadRequest, intToRea2.u) annotation(
    Line(points = {{-120, 26}, {-68, 26}, {-68, 6}}, color = {255, 127, 0}));
  connect(tesColdStatus, intToRea3.u) annotation (Line(points={{-120,-82},{-95,
          -82},{-95,-94},{-72,-94}}, color={255,127,0}));
  connect(systemModeFinal.y, systemMode) annotation (Line(points={{31,-14},{38,
          -14},{38,120},{0,120}}, color={0,0,127}));
  connect(systemModeFinal.y, equipmentControl.u) annotation (Line(points={{31,
          -14},{38,-14},{38,30},{44,30}}, color={0,0,127}));
  connect(equipmentControl.y[1], HotTesValve) annotation (Line(points={{67,30},
          {84,30},{84,106},{120,106}}, color={0,0,127}));
  connect(equipmentControl.y[2], ColdTesValve) annotation (Line(points={{67,30},
          {84,30},{84,80},{120,80}}, color={0,0,127}));
  connect(equipmentControl.y[3], HeatPumpSidePumpFraction) annotation (Line(
        points={{67,30},{86,30},{86,56},{120,56}}, color={0,0,127}));
  connect(equipmentControl.y[4], LoadSidePumpFraction) annotation (Line(points=
          {{67,30},{84,30},{84,24},{120,24}}, color={0,0,127}));
  connect(equipmentControl.y[5], HeatPumpSetpoint) annotation (Line(points={{67,
          30},{84,30},{84,-10},{120,-10}}, color={0,0,127}));
  connect(equipmentControl.y[6], greThr2.u) annotation (Line(points={{67,30},{
          62,30},{62,-32},{52,-32}}, color={0,0,127}));
  connect(equipmentControl.y[7], greThr3.u) annotation (Line(points={{67,30},{
          62,30},{62,-86},{58,-86}}, color={0,0,127}));
  connect(intToRea.y, systemModePre.u1) annotation (Line(points={{-52,54},{-40,
          54},{-40,52},{-32,52}}, color={0,0,127}));
  connect(intToRea2.y, systemModePre.u2)
    annotation (Line(points={{-44,6},{-32,6},{-32,40}}, color={0,0,127}));
  connect(intToRea1.y, tesStatusTable.u1) annotation (Line(points={{-56,-60},{
          -38,-60},{-38,-40},{-28,-40}}, color={0,0,127}));
  connect(intToRea3.y, tesStatusTable.u2) annotation (Line(points={{-48,-94},{
          -36,-94},{-36,-52},{-28,-52}}, color={0,0,127}));
  connect(tesStatusTable.y, systemModeFinal.u2) annotation (Line(points={{-5,
          -46},{0,-46},{0,-20},{8,-20}}, color={0,0,127}));
  connect(systemModePre.y, systemModeFinal.u1)
    annotation (Line(points={{-9,46},{0,46},{0,-8},{8,-8}}, color={0,0,127}));
end hvac_storage_controller;
