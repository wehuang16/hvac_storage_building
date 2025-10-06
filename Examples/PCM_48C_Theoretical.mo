within hvac_storage_building.Examples;
model PCM_48C_Theoretical "Tes storage implementation"
    extends Modelica.Icons.Example;
  replaceable package Medium = Buildings.Media.Water "Medium for water flow";


  parameter Modelica.Units.SI.PressureDifference dpHPC_nominal = 9339;
parameter Modelica.Units.SI.PressureDifference dpLPC_nominal = 32914;

parameter Modelica.Units.SI.MassFlowRate mPCM_flow_nominal=0.3;
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemPCMSupply(redeclare package
      Medium = Medium, m_flow_nominal=mPCM_flow_nominal)
    "Temperature supplying from PCM"       annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-2,8})));

  Buildings.Fluid.Sensors.TemperatureTwoPort senTemPCMReturn(redeclare package
      Medium = Medium, m_flow_nominal=mPCM_flow_nominal)
    "Temperature returning to PCM"                         annotation (
      Placement(transformation(
        extent={{15,15},{-15,-15}},
        rotation=180,
        origin={-181,9})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
                                        TPCM "internal temperature of PCM"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  PCM.CoilRegisterFourPortPCM coilRegisterFourPortPCM(
    m1_flow_nominal=mPCM_flow_nominal/2,
    m2_flow_nominal=mPCM_flow_nominal/2,
    TStart_pcm=313.15,
    Design(
      Tes_nominal(displayUnit="kWh") = 32400000,
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
    annotation (Placement(transformation(extent={{102,-104},{122,-84}})));
  Sensors.ThermalPowerFlowSensor thermalPowerFlowSensor(redeclare package
      Medium = Medium) annotation (Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={41,8})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
                                        QPCM_flow
    "heat flow rate of PCM with flowing water"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  PCM.Data.SunampQ6MaterialProperties sunampQ6MaterialProperties
    annotation (Placement(transformation(extent={{40,100},{60,120}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    m_flow_nominal=mPCM_flow_nominal)
    annotation (Placement(transformation(extent={{-266,6},{-246,26}})));
  Buildings.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    T=323.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-312,6},{-292,28}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=180,
        origin={172,9})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant pump_flow_rate(k=0.35)
    "pump_flow_rate in unit of kg/s"
    annotation (Placement(transformation(extent={{-308,60},{-288,80}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature TA
    "Temperature boundary condition"
    annotation (Placement(transformation(extent={{-132,96},{-112,116}})));
  Buildings.HeatTransfer.Convection.Interior convHot(
    A=1,
    hFixed=0,
    til=Buildings.Types.Tilt.Wall)
    "Convective heat transfer"
    annotation (Placement(transformation(extent={{-64,96},{-84,116}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant ambient_temperature(k=273.15
         + 20)
    "temperature surrounding the PCM in unit of Kelvin, used to calculate thermal loss to the environment"
    annotation (Placement(transformation(extent={{-182,96},{-162,116}})));
equation
  connect(senTemPCMSupply.port_a, coilRegisterFourPortPCM.port_b1) annotation (
      Line(points={{-16,8},{-86,8},{-86,16.2},{-96,16.2}},
                       color={0,127,255}));
  connect(coilRegisterFourPortPCM.port_a2,senTemPCMReturn. port_b) annotation (
      Line(points={{-96,7.8},{-90,7.8},{-90,-4},{-160,-4},{-160,9},{-166,9}},
                                                          color={0,127,255}));
  connect(coilRegisterFourPortPCM.port_a1,senTemPCMReturn. port_b) annotation (
      Line(points={{-116,16.2},{-160,16.2},{-160,9},{-166,9}},
        color={0,127,255}));
  connect(coilRegisterFourPortPCM.port_b2,senTemPCMSupply. port_a) annotation (
      Line(points={{-116,7.8},{-122,7.8},{-122,28},{-26,28},{-26,8},{-16,8}},
                                                                color={0,127,255}));
  connect(coilRegisterFourPortPCM.TPCM, TPCM) annotation (Line(points={{-93.8,12},
          {-24,12},{-24,60},{110,60}},                 color={0,0,127}));
  connect(thermalPowerFlowSensor.Q_flow, QPCM_flow) annotation (Line(points={{41.66,
          -3},{41.66,-20},{110,-20}},
        color={0,0,127}));
  connect(thermalPowerFlowSensor.port_a,senTemPCMSupply. port_b) annotation (
      Line(points={{29.78,7.6},{28,8},{12,8}},           color={0,127,255}));
  connect(senTemPCMReturn.T, thermalPowerFlowSensor.TempSupply) annotation (
      Line(points={{-181,25.5},{-182,25.5},{-182,38},{2,38},{2,28},{41.22,28},{41.22,
          19.2}},                                               color={0,0,127}));
  connect(bou.ports[1], mov.port_a) annotation (Line(points={{-292,17},{-272,17},
          {-272,16},{-266,16}}, color={0,127,255}));
  connect(pump_flow_rate.y, mov.m_flow_in)
    annotation (Line(points={{-286,70},{-256,70},{-256,28}}, color={0,0,127}));
  connect(mov.port_b,senTemPCMReturn. port_a) annotation (Line(points={{-246,16},
          {-202,16},{-202,9},{-196,9}}, color={0,0,127}));
  connect(thermalPowerFlowSensor.port_b, bou1.ports[1]) annotation (Line(points
        ={{52.22,7.6},{156,7.6},{156,9},{162,9}}, color={0,127,255}));
  connect(ambient_temperature.y, TA.T)
    annotation (Line(points={{-160,106},{-134,106}}, color={0,0,127}));
  connect(TA.port, convHot.fluid)
    annotation (Line(points={{-112,106},{-84,106}}, color={191,0,0}));
  connect(convHot.solid, coilRegisterFourPortPCM.heaPorOutside) annotation (
      Line(points={{-64,106},{-58,106},{-58,-6},{-95.4,-6},{-95.4,0.2}}, color={
          191,0,0}));
  connect(SOC, coilRegisterFourPortPCM.SOC) annotation (Line(points={{112,-94},{
          112,-36},{-62,-36},{-62,3},{-95,3}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-120},{100,100}})),
    experiment(
      StartTime=0,
      StopTime=86400,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end PCM_48C_Theoretical;
