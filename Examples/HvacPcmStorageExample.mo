within hvac_storage_building.Examples;
model HvacPcmStorageExample
  extends Modelica.Icons.Example;
  BaseClasses.HvacHotPcmStorage hvacWaterStorage
    annotation (Placement(transformation(extent={{2,-4},{42,16}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.TimeTable dailyScheduleTable(
    table=[0,1; 8,2; 16,3; 21,1; 24,1],
    timeScale=3600,
    period=86400)                                                                                                                                                           annotation(
    Placement(transformation(origin={-60,74},      extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://hvac_storage_building/Resources/Data/low_rise_South_Lake_Tahoe_ideal_load_processed.txt"),
    columns=2:9,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    annotation (Placement(transformation(extent={{-112,12},{-92,32}})));
  Buildings.Controls.OBC.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-40,-4},{-20,16}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=4)
    annotation (Placement(transformation(extent={{-40,-56},{-20,-36}})));
equation
  connect(combiTimeTable.y[1], from_degC.u) annotation (Line(points={{-91,22},{
          -62,22},{-62,6},{-42,6}}, color={0,0,127}));
  connect(from_degC.y, hvacWaterStorage.outside_air_temperature)
    annotation (Line(points={{-18,6},{0.518519,6}}, color={0,0,127}));
  connect(dailyScheduleTable.y[1], hvacWaterStorage.systemCommand) annotation (
      Line(points={{-48,74},{-6,74},{-6,12.2},{0.518519,12.2}}, color={255,127,
          0}));
  connect(gai.y, hvacWaterStorage.ZonLoaReq[1]) annotation (Line(points={{-18,-46},
          {-4,-46},{-4,-1},{0.518519,-1}}, color={0,0,127}));
  connect(combiTimeTable.y[8], gai.u) annotation (Line(points={{-91,22},{-62,22},
          {-62,6},{-50,6},{-50,-46},{-42,-46}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=0,
      StopTime=604800,
      Interval=60,
      __Dymola_Algorithm="Cvode"));
end HvacPcmStorageExample;
