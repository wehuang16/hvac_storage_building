within hvac_storage_building.HeatPumps.BaseClasses;

model HeaPumPer
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
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [-999, 283.15, 303.15; 283.15, 12000, 12000; 303.15, 12000, 12000])  annotation(
    Placement(transformation(origin = {-12, 104}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds1(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [-999, 283.15, 303.15; 283.15, 12000, 12000; 303.15, 12000, 12000]) annotation(
    Placement(transformation(origin = {-7, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds2(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [-999, 283.15, 303.15; 283.15, 4000, 4000; 303.15, 4000, 4000]) annotation(
    Placement(transformation(origin = {13, 29}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds21(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [-999, 283.15, 303.15; 283.15, 4000, 4000; 303.15, 4000, 4000]) annotation(
    Placement(transformation(origin = {12, -9}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds22(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [-999, 283.15, 303.15; 283.15, 4, 4; 303.15, 4, 4]) annotation(
    Placement(transformation(origin = {5, -56}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2Ds221(extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [-999, 283.15, 303.15; 283.15, 4, 4; 303.15, 4, 4]) annotation(
    Placement(transformation(origin = {12, -98}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(TSup, combiTable2Ds.u1) annotation(
    Line(points = {{-120, 60}, {-90, 60}, {-90, 110}, {-24, 110}}, color = {0, 0, 127}));
  connect(TOut, combiTable2Ds.u2) annotation(
    Line(points = {{-120, -42}, {-52, -42}, {-52, 98}, {-24, 98}}, color = {0, 0, 127}));
  connect(combiTable2Ds.y, MaxHeaPumCapHea) annotation(
    Line(points = {{0, 104}, {120, 104}, {120, 86}}, color = {0, 0, 127}));
  connect(TSup, combiTable2Ds1.u1) annotation(
    Line(points = {{-120, 60}, {-38, 60}, {-38, 76}, {-18, 76}}, color = {0, 0, 127}));
  connect(TOut, combiTable2Ds1.u2) annotation(
    Line(points = {{-120, -42}, {-18, -42}, {-18, 64}}, color = {0, 0, 127}));
  connect(combiTable2Ds1.y, MaxHeaPumCapCoo) annotation(
    Line(points = {{4, 70}, {120, 70}, {120, 62}}, color = {0, 0, 127}));
  connect(combiTable2Ds2.y, MinHeaPumCapHea) annotation(
    Line(points = {{24, 30}, {120, 30}, {120, 34}}, color = {0, 0, 127}));
  connect(combiTable2Ds21.y, MinHeaPumCapCoo) annotation(
    Line(points = {{24, -8}, {120, -8}, {120, 8}}, color = {0, 0, 127}));
  connect(TSup, combiTable2Ds2.u1) annotation(
    Line(points = {{-120, 60}, {-30, 60}, {-30, 36}, {2, 36}}, color = {0, 0, 127}));
  connect(TSup, combiTable2Ds21.u1) annotation(
    Line(points = {{-120, 60}, {-82, 60}, {-82, -2}, {0, -2}}, color = {0, 0, 127}));
  connect(TOut, combiTable2Ds2.u2) annotation(
    Line(points = {{-120, -42}, {-62, -42}, {-62, 24}, {2, 24}}, color = {0, 0, 127}));
  connect(TOut, combiTable2Ds21.u2) annotation(
    Line(points = {{-120, -42}, {-70, -42}, {-70, -14}, {0, -14}}, color = {0, 0, 127}));
  connect(TSup, combiTable2Ds22.u1) annotation(
    Line(points = {{-120, 60}, {-6, 60}, {-6, -50}}, color = {0, 0, 127}));
  connect(TSup, combiTable2Ds221.u1) annotation(
    Line(points = {{-120, 60}, {-32, 60}, {-32, -92}, {0, -92}}, color = {0, 0, 127}));
  connect(TOut, combiTable2Ds22.u2) annotation(
    Line(points = {{-120, -42}, {-52, -42}, {-52, -62}, {-6, -62}}, color = {0, 0, 127}));
  connect(TOut, combiTable2Ds221.u2) annotation(
    Line(points = {{-120, -42}, {-70, -42}, {-70, -104}, {0, -104}}, color = {0, 0, 127}));
  connect(combiTable2Ds22.y, COPHea) annotation(
    Line(points = {{16, -56}, {120, -56}, {120, -46}}, color = {0, 0, 127}));
  connect(combiTable2Ds221.y, COPCoo) annotation(
    Line(points = {{24, -98}, {120, -98}, {120, -82}}, color = {0, 0, 127}));

end HeaPumPer;
