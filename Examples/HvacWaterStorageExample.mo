within hvac_storage_building.Examples;
model HvacWaterStorageExample
  BaseClasses.HvacWaterStorage2 hvacWaterStorage
    annotation (Placement(transformation(extent={{2,-4},{42,16}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.TimeTable dailyScheduleTable(
    table=[0,1; 2,1; 4,1; 6,3; 10,3; 16,4; 21,1; 24,1],
    timeScale=3600,
    period=86400)                                                                                                                                                           annotation(
    Placement(transformation(origin={-60,74},      extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 20)    annotation(
    Placement(transformation(origin={-96,-2},    extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin(
    amplitude=3000,
    freqHz=1/86400,
    phase=0.78539816339745,
    offset=1000)
    annotation (Placement(transformation(extent={{-72,-54},{-52,-34}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1[5](k=0) annotation (
      Placement(transformation(origin={-38,-86}, extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.TimeTable dailyScheduleTableAlternative(
    table=[0,1; 2,1; 4,1; 6,1; 10,1; 16,1; 21,1; 24,1],
    timeScale=3600,
    period=86400) annotation (Placement(transformation(origin={-48,34}, extent=
            {{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="tab1",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://hvac_storage_building/Resources/Data/low_rise_Sacramento_ideal_load_processed.txt"),
    columns=2:9,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    annotation (Placement(transformation(extent={{-112,12},{-92,32}})));
  Buildings.Controls.OBC.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-40,-4},{-20,16}})));
equation
  connect(combiTimeTable.y[1], from_degC.u) annotation (Line(points={{-91,22},{
          -62,22},{-62,6},{-42,6}}, color={0,0,127}));
  connect(from_degC.y, hvacWaterStorage.outside_air_temperature)
    annotation (Line(points={{-18,6},{0.518519,6}}, color={0,0,127}));
  connect(combiTimeTable.y[2:7], hvacWaterStorage.ZonLoaReq) annotation (Line(
        points={{-91,22},{-62,22},{-62,6},{-50,6},{-50,-10},{-6,-10},{-6,-1},{
          0.518519,-1}}, color={0,0,127}));
  connect(dailyScheduleTable.y[1], hvacWaterStorage.systemCommand) annotation (
      Line(points={{-48,74},{-6,74},{-6,12.2},{0.518519,12.2}}, color={255,127,
          0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=18230400,
      StopTime=18403200,
      Interval=60,
      __Dymola_Algorithm="Cvode"));
end HvacWaterStorageExample;
