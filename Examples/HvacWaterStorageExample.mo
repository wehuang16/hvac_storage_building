within hvac_storage_building.Examples;
model HvacWaterStorageExample
  BaseClasses.HvacWaterStorage hvacWaterStorage
    annotation (Placement(transformation(extent={{2,-4},{42,16}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.TimeTable dailyScheduleTable(
    table=[0,1; 2,0; 4,1; 8,2; 12,2; 16,4; 21,1; 24,1],
    timeScale=3600,
    period=86400)                                                                                                                                                           annotation(
    Placement(transformation(origin={-60,74},      extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 20)    annotation(
    Placement(transformation(origin={-96,-2},    extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin(
    amplitude=2000,
    freqHz=1/86400,
    phase=3.9269908169872,
    offset=2000)
    annotation (Placement(transformation(extent={{-72,-54},{-52,-34}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1[2](k=0) annotation (
      Placement(transformation(origin={-38,-86}, extent={{-10,-10},{10,10}})));
equation
  connect(dailyScheduleTable.y[1], hvacWaterStorage.systemCommand) annotation (
      Line(points={{-48,74},{0.518519,74},{0.518519,12.2}}, color={255,127,0}));
  connect(con.y, hvacWaterStorage.outside_air_temperature) annotation (Line(
        points={{-84,-2},{-6,-2},{-6,6},{0.518519,6}}, color={0,0,127}));
  connect(sin.y, hvacWaterStorage.ZonLoaReq[1]) annotation (Line(points={{-50,
          -44},{-12,-44},{-12,-4},{-4,-4},{-4,-1},{0.518519,-1}}, color={0,0,
          127}));
  connect(con1.y, hvacWaterStorage.ZonLoaReq[2:3]) annotation (Line(points={{
          -26,-86},{-12,-86},{-12,-4},{-4,-4},{-4,-1},{0.518519,-1}}, color={0,
          0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end HvacWaterStorageExample;
