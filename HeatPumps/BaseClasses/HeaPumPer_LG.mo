within hvac_storage_building.HeatPumps.BaseClasses;
model HeaPumPer_LG
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSup annotation(
    Placement(transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-116, 56}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOut annotation(
    Placement(transformation(origin = {-120, -42}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -46}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput MaxHeaPumCapHea annotation(
    Placement(transformation(origin = {120, 86}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 92}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput MinHeaPumCapHea annotation(
    Placement(transformation(origin = {120, 34}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 36}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput MaxHeaPumCapCoo annotation(
    Placement(transformation(origin = {120, 62}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 66}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput MinHeaPumCapCoo annotation(
    Placement(transformation(origin = {120, 8}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 10}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput COPHea annotation(
    Placement(transformation(origin = {120, -46}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, -46}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput COPCoo annotation(
    Placement(transformation(origin = {120, -82}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, -84}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table=[0,
        248.15,253.15,258.15,266.15,269.15,271.15,275.15,280.15,283.15,288.15,
        291.15,293.15,308.15; 303.15,8750,10130,11500,12000,12000,12000,12000,
        12000,12000,12000,12000,12000,12000; 308.15,8500,10000,11500,12000,
        12000,12000,12000,12000,12000,12000,12000,12000,12000; 313.15,8250,9880,
        11500,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000;
        318.15,8000,9750,11500,12000,12000,12000,12000,12000,12000,12000,12000,
        12000,12000; 323.15,9630,9630,11500,12000,12000,12000,12000,12000,12000,
        12000,12000,12000,12000; 328.15,11500,11500,11500,12000,12000,12000,
        12000,12000,12000,12000,12000,12000,12000; 333.15,12000,12000,12000,
        12000,12000,12000,12000,12000,12000,12000,12000,12000,12000; 338.15,
        12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,12000,
        12000])                                                                                                                                                                                      annotation(
    Placement(transformation(origin = {-12, 104}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds1(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table=[0,
        283.15,293.15,303.15,308.15,313.15,318.15; 280.15,11250,11550,11850,
        12000,12150,12300; 283.15,12330,12200,12070,12000,12000,12000; 286.15,
        13400,12840,12280,12000,11850,11690; 288.15,14120,13270,12420,12000,
        11750,11490; 291.15,15200,13920,12640,12000,11590,11190; 293.15,15910,
        14350,12780,12000,11490,10990; 295.15,16630,14780,12930,12000,11390,
        10780])                                                                                                                                                                                      annotation(
    Placement(transformation(origin = {-7, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds2(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table=[0,
        248.15,253.15,258.15,266.15,269.15,271.15,275.15,280.15,283.15,288.15,
        291.15,293.15,308.15; 303.15,2625,3039,3450,3600,3600,3600,3600,3600,
        3600,3600,3600,3600,3600; 308.15,2550,3000,3450,3600,3600,3600,3600,
        3600,3600,3600,3600,3600,3600; 313.15,2475,2964,3450,3600,3600,3600,
        3600,3600,3600,3600,3600,3600,3600; 318.15,2400,2925,3450,3600,3600,
        3600,3600,3600,3600,3600,3600,3600,3600; 323.15,2889,2889,3450,3600,
        3600,3600,3600,3600,3600,3600,3600,3600,3600; 328.15,3450,3450,3450,
        3600,3600,3600,3600,3600,3600,3600,3600,3600,3600; 333.15,3600,3600,
        3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600; 338.15,3600,
        3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600,3600])                                                                                                                            annotation(
    Placement(transformation(origin = {13, 29}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds21(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table=[0,
        283.15,293.15,303.15,308.15,313.15,318.15; 280.15,3375,3465,3555,3600,
        3645,3690; 283.15,3699,3660,3621,3600,3600,3600; 286.15,4020,3852,3684,
        3600,3555,3507; 288.15,4236,3981,3726,3600,3525,3447; 291.15,4560,4176,
        3792,3600,3477,3357; 293.15,4773,4305,3834,3600,3447,3297; 295.15,4989,
        4434,3879,3600,3417,3234])                                                                                                                                                                annotation(
    Placement(transformation(origin = {12, -9}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds22(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table=[0,
        248.15,253.15,258.15,266.15,269.15,271.15,275.15,280.15,283.15,288.15,
        291.15,293.15,308.15; 303.15,2.13,2.34,2.55,3.15,3.36,3.47,3.69,4.93,
        5.22,5.99,6.29,6.49,7.98; 308.15,1.85,2.13,2.4,3,3.17,3.28,3.5,4.6,4.87,
        5.56,5.84,6.02,7.41; 313.15,1.58,1.91,2.25,2.85,2.97,3.09,3.31,4.27,
        4.51,5.13,5.39,5.56,6.84; 318.15,1.3,1.7,2.1,2.7,2.78,2.9,3.12,3.93,
        4.16,4.71,4.94,5.1,6.28; 323.15,1.49,1.49,1.95,2.55,2.59,2.71,2.93,3.6,
        3.81,4.28,4.49,4.64,5.71; 328.15,1.8,1.8,1.8,2.4,2.39,2.53,2.73,2.8,
        3.46,3.85,4.05,4.17,5.14; 333.15,2.25,2.25,2.25,2.25,2.2,2.34,2.54,2.6,
        3.1,3.43,3.6,3.71,4.57; 338.15,2.05,2.05,2.05,2.05,2.05,2.15,2.35,2.6,
        2.75,3,3.15,3.25,4])                                                                                                                                                          annotation(
    Placement(transformation(origin = {5, -56}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds221(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table=[0,
        283.15,293.15,303.15,308.15,313.15,318.15; 280.15,4.43,3.74,3.05,2.7,
        2.35,2.01; 283.15,4.86,4.2,3.55,3.22,2.85,2.48; 286.15,5.29,4.67,4.05,
        3.74,3.35,2.95; 288.15,5.58,4.98,4.38,4.08,3.68,3.27; 291.15,6.01,5.45,
        4.88,4.6,4.17,3.74; 293.15,6.3,5.76,5.22,4.95,4.5,4.06; 295.15,6.59,
        6.07,5.55,5.29,4.83,4.37])                                                                                                                                                     annotation(
    Placement(transformation(origin = {12, -98}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(TSup, combiTable2Ds.u1) annotation(
    Line(points = {{-120, 60}, {-90, 60}, {-90, 110}, {-24, 110}}, color = {0, 0, 127}));
  connect(TOut, combiTable2Ds.u2) annotation(
    Line(points = {{-120, -42}, {-52, -42}, {-52, 98}, {-24, 98}}, color = {0, 0, 127}));
  connect(combiTable2Ds.y, MaxHeaPumCapHea) annotation(
    Line(points={{-1,104},{120,104},{120,86}},       color = {0, 0, 127}));
  connect(TSup, combiTable2Ds1.u1) annotation(
    Line(points={{-120,60},{-38,60},{-38,76},{-19,76}},          color = {0, 0, 127}));
  connect(TOut, combiTable2Ds1.u2) annotation(
    Line(points={{-120,-42},{-19,-42},{-19,64}},        color = {0, 0, 127}));
  connect(combiTable2Ds1.y, MaxHeaPumCapCoo) annotation(
    Line(points = {{4, 70}, {120, 70}, {120, 62}}, color = {0, 0, 127}));
  connect(combiTable2Ds2.y, MinHeaPumCapHea) annotation(
    Line(points={{24,29},{120,29},{120,34}},        color = {0, 0, 127}));
  connect(combiTable2Ds21.y, MinHeaPumCapCoo) annotation(
    Line(points={{23,-9},{120,-9},{120,8}},        color = {0, 0, 127}));
  connect(TSup, combiTable2Ds2.u1) annotation(
    Line(points={{-120,60},{-30,60},{-30,35},{1,35}},          color = {0, 0, 127}));
  connect(TSup, combiTable2Ds21.u1) annotation(
    Line(points={{-120,60},{-82,60},{-82,-3},{0,-3}},          color = {0, 0, 127}));
  connect(TOut, combiTable2Ds2.u2) annotation(
    Line(points={{-120,-42},{-62,-42},{-62,23},{1,23}},          color = {0, 0, 127}));
  connect(TOut, combiTable2Ds21.u2) annotation(
    Line(points={{-120,-42},{-70,-42},{-70,-15},{0,-15}},          color = {0, 0, 127}));
  connect(TSup, combiTable2Ds22.u1) annotation(
    Line(points={{-120,60},{-7,60},{-7,-50}},        color = {0, 0, 127}));
  connect(TSup, combiTable2Ds221.u1) annotation(
    Line(points = {{-120, 60}, {-32, 60}, {-32, -92}, {0, -92}}, color = {0, 0, 127}));
  connect(TOut, combiTable2Ds22.u2) annotation(
    Line(points={{-120,-42},{-52,-42},{-52,-62},{-7,-62}},          color = {0, 0, 127}));
  connect(TOut, combiTable2Ds221.u2) annotation(
    Line(points = {{-120, -42}, {-70, -42}, {-70, -104}, {0, -104}}, color = {0, 0, 127}));
  connect(combiTable2Ds22.y, COPHea) annotation(
    Line(points = {{16, -56}, {120, -56}, {120, -46}}, color = {0, 0, 127}));
  connect(combiTable2Ds221.y, COPCoo) annotation(
    Line(points={{23,-98},{120,-98},{120,-82}},        color = {0, 0, 127}));

end HeaPumPer_LG;
