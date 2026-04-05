within hvac_storage_building.Examples.BaseClasses.Validation;
model PCM_48C_Theoretical_block

extends Modelica.Icons.Example;
    package MediumAir=Buildings.Media.Air
    "Medium model";
  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+20, X_a=
            0.4);
  parameter Modelica.Units.SI.MassFlowRate mPCM_flow_nominal=0.3;



  hvac_storage_building.Examples.BaseClasses.PCM_48C_Theoretical_block
    pCM_48C_Theoretical_block(redeclare package Medium = MediumWater,
      mPCM_flow_nominal=mPCM_flow_nominal)
    annotation (Placement(transformation(extent={{-22,-12},{4,10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant ambient_temperature(k=273.15
         + 20)
    "temperature surrounding the PCM in unit of Kelvin, used to calculate thermal loss to the environment"
    annotation (Placement(transformation(extent={{-80,44},{-60,64}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature TA
    "Temperature boundary condition"
    annotation (Placement(transformation(extent={{-30,44},{-10,64}})));
  Buildings.HeatTransfer.Convection.Interior convHot(
    A=1,
    hFixed=10,
    til=Buildings.Types.Tilt.Wall)
    "Convective heat transfer"
    annotation (Placement(transformation(extent={{38,44},{18,64}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov(
    redeclare package Medium = MediumWater,
    addPowerToMedium=false,
    m_flow_nominal=mPCM_flow_nominal)
    annotation (Placement(transformation(extent={{-116,-72},{-96,-52}})));
  Buildings.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = MediumWater,
    T=328.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-162,-72},{-142,-50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin      pump_flow_rate(amplitude=
        mPCM_flow_nominal,
      freqHz(displayUnit="s-1") = 1/43200)
    "pump_flow_rate in unit of kg/s"
    annotation (Placement(transformation(extent={{-158,-18},{-138,2}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        MediumWater, nPorts=1)
                annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=180,
        origin={98,-7})));
equation
  connect(ambient_temperature.y, TA.T)
    annotation (Line(points={{-58,54},{-32,54}}, color={0,0,127}));
  connect(TA.port, convHot.fluid)
    annotation (Line(points={{-10,54},{18,54}}, color={191,0,0}));
  connect(convHot.solid, pCM_48C_Theoretical_block.heaPorOutside) annotation (
      Line(points={{38,54},{42,54},{42,16},{-7.2,16},{-7.2,10.4}}, color={191,0,
          0}));
  connect(bou.ports[1],mov. port_a) annotation (Line(points={{-142,-61},{-122,-61},
          {-122,-62},{-116,-62}},
                                color={0,127,255}));
  connect(pump_flow_rate.y,mov. m_flow_in)
    annotation (Line(points={{-136,-8},{-106,-8},{-106,-50}},color={0,0,127}));
  connect(mov.port_b, pCM_48C_Theoretical_block.port_a) annotation (Line(points
        ={{-96,-62},{-28,-62},{-28,7.6},{-22.4,7.6}}, color={0,0,127}));
  connect(pCM_48C_Theoretical_block.port_b, bou1.ports[1]) annotation (Line(
        points={{4.4,7.8},{82,7.8},{82,-7},{88,-7}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end PCM_48C_Theoretical_block;
