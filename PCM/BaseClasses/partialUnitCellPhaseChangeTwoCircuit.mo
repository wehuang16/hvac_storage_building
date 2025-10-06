within hvac_storage_building.PCM.BaseClasses;
model partialUnitCellPhaseChangeTwoCircuit
  replaceable parameter hvac_storage_building.PCM.Data.SunampQ6HeatExchanger Design "Design of HX";
  parameter Modelica.Units.SI.Area A_tubeLPC = Design.A_tubeLPC "Heat transfer area of LPC tube";
  parameter Modelica.Units.SI.Area A_tubeHPC = Design.A_tubeHPC "Heat transfer area of LPC tube";
  parameter Modelica.Units.SI.Area A_fin = Design.A_fin "Heat transfer area of fin";
  parameter Modelica.Units.SI.Area A_pcm = Design.A_pcm "Heat transfer area of pcm";
  parameter Modelica.Units.SI.Temperature TStart_pcm "Starting temperature of pcm" annotation(Dialog(tab="General", group="Initialization"));
  replaceable parameter Buildings.HeatTransfer.Data.SolidsPCM.Generic PCM = Design.PCM "Storage material record" annotation (Placement(transformation(extent={{60,80},{80,100}})));
  replaceable parameter Buildings.HeatTransfer.Data.Solids.Generic Copper = Design.Copper "Tube material record" annotation (Placement(transformation(extent={{4,80},{24,100}})));
  replaceable parameter Buildings.HeatTransfer.Data.Solids.Generic Aluminum = Design.Aluminum "Fin material record" annotation (Placement(transformation(extent={{32,80},{52,100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a tubHeaPort_b2 annotation (Placement(transformation(extent={{-110,-48},{-90,-28}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b tubHeaPort_a2 annotation (Placement(transformation(extent={{90,-48},{110,-28}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a tubHeaPort_a1 annotation (Placement(transformation(extent={{-110,28},{-90,48}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b tubHeaPort_b1 annotation (Placement(transformation(extent={{90,28},{110,48}})));
  Buildings.HeatTransfer.Conduction.SingleLayer tubeHPC(
    stateAtSurface_b=false,
    T_a_start=TStart_pcm,
    T_b_start=TStart_pcm,
    material=Copper,
    A=A_tubeHPC) "Copper tubes in high power circuit (HPC) for discharge"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,48})));
  Buildings.HeatTransfer.Conduction.SingleLayer tubeLPC(
    stateAtSurface_b=false,
    T_a_start=TStart_pcm,
    T_b_start=TStart_pcm,
    material=Copper,
    A=A_tubeLPC) "Copper tubes in low power circuit (LPC) for charge"   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,-48})));
  Buildings.HeatTransfer.Conduction.SingleLayer finsHPC(
    stateAtSurface_b=false,
    T_a_start=TStart_pcm,
    T_b_start=TStart_pcm,
    material=Aluminum,
    A=A_fin) "Aluminum fins between HPC tubes and PCM" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,24})));
  Buildings.HeatTransfer.Conduction.SingleLayer finsLPC(
    stateAtSurface_b=false,
    T_a_start=TStart_pcm,
    T_b_start=TStart_pcm,
    material=Aluminum,
    A=A_fin) "Aluminum fins between LPC tubes and PCM" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,-24})));
  Buildings.HeatTransfer.Conduction.SingleLayer pcm(
    stateAtSurface_b=false,
    material=PCM,
    A=A_pcm,
    T_a_start=TStart_pcm,
    T_b_start=TStart_pcm) "Sodium acetate trihydrate energy storage material" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFloHPC
    annotation (Placement(transformation(extent={{-58,20},{-70,8}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFloLPC
    annotation (Placement(transformation(extent={{-70,-16},{-58,-4}})));
  Modelica.Blocks.Sources.RealExpression USum(y = sum((pcm.u[i]*pcm.m[i]) for i in 1:size(pcm.u, 1))) annotation(
    Placement(transformation(extent = {{-80, -2}, {-100, 18}})));
  Modelica.Blocks.Sources.RealExpression mSum(y = sum((pcm.m[i]) for i in 1:size(pcm.u, 1))) annotation(
    Placement(transformation(extent = {{-80, 2}, {-100, -18}})));
equation
  connect(tubeHPC.port_a, finsHPC.port_b)
    annotation (Line(points={{-40,38},{-40,34}}, color={191,0,0}));
  connect(finsLPC.port_b,tubeLPC. port_a)
    annotation (Line(points={{-40,-34},{-40,-38}}, color={191,0,0}));
  connect(tubeHPC.port_a, tubHeaPort_a1)
    annotation (Line(points={{-40,38},{-100,38}}, color={191,0,0}));
  connect(tubeHPC.port_a, tubHeaPort_b1)
    annotation (Line(points={{-40,38},{100,38}}, color={191,0,0}));
  connect(tubeLPC.port_a, tubHeaPort_b2)
    annotation (Line(points={{-40,-38},{-100,-38}}, color={191,0,0}));
  connect(tubeLPC.port_a, tubHeaPort_a2)
    annotation (Line(points={{-40,-38},{100,-38}}, color={191,0,0}));
  connect(pcm.port_a, heaFloLPC.port_b)
    annotation (Line(points={{-40,-10},{-58,-10}}, color={191,0,0}));
  connect(heaFloLPC.port_a, finsLPC.port_a)
    annotation (Line(points={{-70,-10},{-70,-14},{-40,-14}}, color={191,0,0}));
  connect(heaFloHPC.port_a, finsHPC.port_a)
    annotation (Line(points={{-58,14},{-40,14}}, color={191,0,0}));
  connect(heaFloHPC.port_b, pcm.port_b)
    annotation (Line(points={{-70,14},{-70,10},{-40,10}}, color={191,0,0}));
  annotation (Icon(graphics={
          Rectangle(
          extent={{-70,60},{70,-66}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag)}));
end partialUnitCellPhaseChangeTwoCircuit;
