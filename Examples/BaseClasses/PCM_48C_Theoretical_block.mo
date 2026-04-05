within hvac_storage_building.Examples.BaseClasses;
block PCM_48C_Theoretical_block "Tes storage implementation"

  replaceable package Medium = Buildings.Media.Water "Medium for water flow";

  parameter Modelica.Units.SI.PressureDifference dpHPC_nominal = 9339;
parameter Modelica.Units.SI.PressureDifference dpLPC_nominal = 32914;

parameter Modelica.Units.SI.MassFlowRate mPCM_flow_nominal=0.3;
parameter Modelica.Units.SI.Temperature TStart_pcm=273.15+40 "Starting temperature of pcm";

  parameter Real TSol(unit="K",displayUnit="degC")= 273.15+47 "Solidus temperature, used only for warm PCM.";
  parameter Real TLiq(unit="K",displayUnit="degC")= 273.15+49 "Liquidus temperature, used only for warm PCM";
parameter Modelica.Units.SI.SpecificHeatCapacity cPCM = 3150 "Specific heat capacity of warm PCM" annotation(Dialog(group="Material Properties"));
    parameter Modelica.Units.SI.Energy Tes_nominal=9*3600000;
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemPCM2(redeclare package
      Medium = Medium, m_flow_nominal=mPCM_flow_nominal)
    "Temperature supplying from PCM" annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={14,6})));

  Buildings.Fluid.Sensors.TemperatureTwoPort senTemPCM1(redeclare package
      Medium = Medium, m_flow_nominal=mPCM_flow_nominal)
    "Temperature returning to PCM" annotation (Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=180,
        origin={-181,9})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
                                        TPCM(final unit="K",final displayUnit="degC") "internal temperature of PCM"
    annotation (Placement(transformation(extent={{100,22},{120,42}})));
  PCM.CoilRegisterFourPortPCM coilRegisterFourPortPCM(
    m1_flow_nominal=mPCM_flow_nominal/2,
    m2_flow_nominal=mPCM_flow_nominal/2,
    TStart_pcm=313.15,
    Design(
      Tes_nominal(displayUnit="kWh") = Tes_nominal,
      dp1_nominal=dpHPC_nominal,
      dp2_nominal=dpLPC_nominal,
      PCM(
        k=sunampQ6MaterialProperties.kPCMLow,
        c=sunampQ6MaterialProperties.cPCMLow,
        d=sunampQ6MaterialProperties.dPCMLow,
        TSol=sunampQ6MaterialProperties.TSolLow,
        TLiq=sunampQ6MaterialProperties.TLiqLow,
        LHea=sunampQ6MaterialProperties.LHeaLow)),
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-116,2},{-96,22}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
                                        SOC "state of charge of PCM"
    annotation (Placement(transformation(extent={{100,-120},{120,-100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput Q_input
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  PCM.Data.SunampQ6MaterialProperties sunampQ6MaterialProperties(TSolLow=TSol,
      TLiqLow=TLiq,
    cPCMLow=cPCM)
    annotation (Placement(transformation(extent={{40,100},{60,120}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-174,66},{-154,86}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{94,68},{114,88}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput T_inlet(final unit="K",final displayUnit="degC")
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput T_outlet(final unit="K",final displayUnit="degC")
    "heat flow rate of PCM with flowing water"
    annotation (Placement(transformation(extent={{100,-88},{120,-68}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium) "Temperature returning to PCM" annotation (Placement(
        transformation(
        extent={{15,15},{-15,-15}},
        rotation=180,
        origin={123,7})));
  Subsequences.HeatFlowCalculation heatFlowCalculation
    annotation (Placement(transformation(extent={{12,-56},{32,-36}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorOutside
    annotation (Placement(transformation(extent={{-22,94},{-2,114}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr
    annotation (Placement(transformation(extent={{-128,-88},{-108,-68}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{-40,-88},{-20,-68}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi1
    annotation (Placement(transformation(extent={{-42,-148},{-22,-128}})));
  Buildings.Controls.OBC.CDL.Reals.Abs abs1
    annotation (Placement(transformation(extent={{-42,-48},{-22,-28}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput m_flow
    annotation (Placement(transformation(extent={{100,-168},{120,-148}})));
equation
  connect(senTemPCM2.port_a, coilRegisterFourPortPCM.port_b1) annotation (Line(
        points={{0,6},{-86,6},{-86,16.2},{-96,16.2}}, color={0,127,255}));
  connect(coilRegisterFourPortPCM.port_a2, senTemPCM1.port_b) annotation (Line(
        points={{-96,7.8},{-90,7.8},{-90,-4},{-160,-4},{-160,9},{-166,9}},
        color={0,127,255}));
  connect(coilRegisterFourPortPCM.port_a1, senTemPCM1.port_b) annotation (Line(
        points={{-116,16.2},{-160,16.2},{-160,9},{-166,9}}, color={0,127,255}));
  connect(coilRegisterFourPortPCM.port_b2, senTemPCM2.port_a) annotation (Line(
        points={{-116,7.8},{-122,7.8},{-122,28},{-26,28},{-26,6},{0,6}}, color={
          0,127,255}));
  connect(coilRegisterFourPortPCM.TPCM, TPCM) annotation (Line(points={{-93.8,12},
          {-24,12},{-24,32},{110,32}},                 color={0,0,127}));
  connect(SOC, coilRegisterFourPortPCM.SOC) annotation (Line(points={{110,-110},
          {-62,-110},{-62,3},{-95,3}},         color={0,0,127}));
  connect(port_a, senTemPCM1.port_a) annotation (Line(points={{-164,76},{-236,76},
          {-236,9},{-196,9}}, color={0,127,255}));
  connect(senMasFlo.port_b, port_b) annotation (Line(points={{138,7},{162,7.6},{
          162,78},{104,78}}, color={0,127,255}));
  connect(heatFlowCalculation.Q_input, Q_input) annotation (Line(points={{34,-46},
          {94,-46},{94,-20},{110,-20}}, color={0,0,127}));
  connect(heaPorOutside, coilRegisterFourPortPCM.heaPorOutside) annotation (
      Line(points={{-12,104},{-50,104},{-50,0.2},{-95.4,0.2}}, color={191,0,0}));
  connect(senMasFlo.m_flow, lesThr.u) annotation (Line(points={{123,23.5},{188,23.5},
          {188,-122},{-140,-122},{-140,-78},{-130,-78}}, color={0,0,127}));
  connect(lesThr.y, swi.u2)
    annotation (Line(points={{-106,-78},{-42,-78}}, color={255,0,255}));
  connect(swi.y, T_inlet) annotation (Line(points={{-18,-78},{42,-78},{42,-50},{
          110,-50}}, color={0,0,127}));
  connect(swi1.y, T_outlet) annotation (Line(points={{-20,-138},{6,-138},{6,-80},
          {94,-80},{94,-78},{110,-78}}, color={0,0,127}));
  connect(lesThr.y, swi1.u2) annotation (Line(points={{-106,-78},{-64,-78},{-64,
          -138},{-44,-138}}, color={255,0,255}));
  connect(senTemPCM2.T, swi.u1) annotation (Line(points={{14,21.4},{14,28},{-6,28},
          {-6,-62},{-42,-62},{-42,-70}}, color={0,0,127}));
  connect(senTemPCM1.T, swi.u3) annotation (Line(points={{-181,25.5},{-181,-86},
          {-42,-86}}, color={0,0,127}));
  connect(senTemPCM1.T, swi1.u1) annotation (Line(points={{-181,25.5},{-181,-130},
          {-44,-130}}, color={0,0,127}));
  connect(senTemPCM2.T, swi1.u3) annotation (Line(points={{14,21.4},{14,-146},{-44,
          -146}}, color={0,0,127}));
  connect(senTemPCM2.port_b, senMasFlo.port_a) annotation (Line(points={{28,6},{
          102,6},{102,7},{108,7}}, color={0,127,255}));
  connect(abs1.y, heatFlowCalculation.m_flow) annotation (Line(points={{-20,-38},
          {-18,-38.6},{10,-38.6}}, color={0,0,127}));
  connect(senMasFlo.m_flow, abs1.u) annotation (Line(points={{123,23.5},{188,23.5},
          {188,-122},{-50,-122},{-50,-46},{-52,-46},{-52,-38},{-44,-38}}, color
        ={0,0,127}));
  connect(swi.y, heatFlowCalculation.T_in) annotation (Line(points={{-18,-78},{0,
          -78},{0,-46},{10,-46}}, color={0,0,127}));
  connect(swi1.y, heatFlowCalculation.T_out) annotation (Line(points={{-20,-138},
          {6,-138},{6,-62},{2,-62},{2,-54},{10,-54}}, color={0,0,127}));
  connect(abs1.y, m_flow) annotation (Line(points={{-20,-38},{-2,-38},{-2,-148},
          {94,-148},{94,-142},{110,-142},{110,-158}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},
            {100,100}},
        grid={2,2})),                                            Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{100,100}},
        grid={2,2})),
    experiment(
      StartTime=0,
      StopTime=86400,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end PCM_48C_Theoretical_block;
