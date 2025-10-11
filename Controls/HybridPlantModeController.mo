within hvac_storage_building.Controls;

model HybridPlantModeController
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput modeInput annotation(
    Placement(transformation(origin = {-122, 84}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-122, 84}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput modeZone annotation(
    Placement(transformation(origin = {-122, 24}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-122, 24}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput modeHotTes annotation(
    Placement(transformation(origin = {-124, -36}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-124, -36}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput modeColdTes annotation(
    Placement(transformation(origin = {-124, -84}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-124, -84}, extent = {{-20, -20}, {20, 20}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea annotation(
    Placement(transformation(origin = {-74, 84}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea1 annotation(
    Placement(transformation(origin = {-63, 30}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea11 annotation(
    Placement(transformation(origin = {-67, -30}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea111 annotation(
    Placement(transformation(origin = {-69, -82}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Tables.CombiTable2Ds systemModePre annotation(
    Placement(transformation(origin = {-18, 68}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(modeInput, intToRea.u) annotation(
    Line(points = {{-122, 84}, {-86, 84}}, color = {255, 127, 0}));
  connect(modeZone, intToRea1.u) annotation(
    Line(points = {{-122, 24}, {-74, 24}, {-74, 30}}, color = {255, 127, 0}));
  connect(modeHotTes, intToRea11.u) annotation(
    Line(points = {{-124, -36}, {-78, -36}, {-78, -30}}, color = {255, 127, 0}));
  connect(modeColdTes, intToRea111.u) annotation(
    Line(points = {{-124, -84}, {-80, -84}, {-80, -82}}, color = {255, 127, 0}));
end HybridPlantModeController;
