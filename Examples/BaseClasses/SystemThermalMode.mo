within hvac_storage_building.Examples.BaseClasses;
block SystemThermalMode

  parameter Integer numZon=20 "number of zones";
  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr[numZon]
    annotation (Placement(transformation(extent={{-72,16},{-52,36}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger
                                                       booToInt1
                                                               [numZon]
    annotation (Placement(transformation(extent={{-28,16},{-8,36}})));
  Buildings.Controls.OBC.CDL.Integers.LessThreshold intLesThr[numZon]
    annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger
                                                       booToInt2[numZon]
    annotation (Placement(transformation(extent={{-34,-36},{-14,-16}})));
  Buildings.Controls.OBC.CDL.Integers.MultiSum
                                            mulSumInt(nin=numZon)
    annotation (Placement(transformation(extent={{14,16},{34,36}})));
  Buildings.Controls.OBC.CDL.Integers.MultiSum
                                            mulSumInt1(nin=numZon)
    annotation (Placement(transformation(extent={{12,-36},{32,-16}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput reqSpaCon[numZon]
    "request space conditioning" annotation (Placement(transformation(extent={{-140,
            -20},{-100,20}}),       iconTransformation(extent={{-140,-20},{-100,
            20}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterEqual intGreEqu
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput ySysHeaCooMod
    annotation (Placement(transformation(extent={{160,-20},{200,20}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt(integerFalse
      =-1) annotation (Placement(transformation(extent={{118,-16},{138,4}})));
  Buildings.Controls.OBC.CDL.Integers.LessEqualThreshold intLesEquThr
    annotation (Placement(transformation(extent={{48,78},{68,98}})));
  Buildings.Controls.OBC.CDL.Integers.LessEqualThreshold intLesEquThr1
    annotation (Placement(transformation(extent={{54,42},{74,62}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{84,60},{104,80}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{122,60},{142,80}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=0)
    annotation (Placement(transformation(extent={{82,104},{102,124}})));
equation
  connect(reqSpaCon,intGreThr. u) annotation (Line(points={{-120,0},{-84,0},{
          -84,26},{-74,26}},    color={255,127,0}));
  connect(intGreThr.y, booToInt1.u)
    annotation (Line(points={{-50,26},{-30,26}}, color={255,0,255}));
  connect(reqSpaCon,intLesThr. u) annotation (Line(points={{-120,0},{-76,0},{
          -76,-26},{-72,-26}},  color={255,127,0}));
  connect(intLesThr.y,booToInt2. u)
    annotation (Line(points={{-48,-26},{-36,-26}}, color={255,0,255}));
  connect(intGreEqu.y, booToInt.u) annotation (Line(points={{70,0},{106,0},{106,
          -6},{116,-6}}, color={255,0,255}));
  connect(booToInt1.y, mulSumInt.u)
    annotation (Line(points={{-6,26},{12,26}}, color={255,127,0}));
  connect(booToInt2.y, mulSumInt1.u)
    annotation (Line(points={{-12,-26},{10,-26}}, color={255,127,0}));
  connect(mulSumInt.y, intGreEqu.u1) annotation (Line(points={{36,26},{44,26},{
          44,8},{38,8},{38,0},{46,0}}, color={255,127,0}));
  connect(mulSumInt1.y, intGreEqu.u2)
    annotation (Line(points={{34,-26},{46,-26},{46,-8}}, color={255,127,0}));
  connect(mulSumInt.y, intLesEquThr.u) annotation (Line(points={{36,26},{44,26},
          {44,80},{38,80},{38,88},{46,88}}, color={255,127,0}));
  connect(mulSumInt1.y, intLesEquThr1.u) annotation (Line(points={{34,-26},{46,
          -26},{46,-16},{38,-16},{38,-2},{36,-2},{36,12},{42,12},{42,18},{46,18},
          {46,34},{42,34},{42,52},{52,52}}, color={255,127,0}));
  connect(intLesEquThr.y, and2.u1) annotation (Line(points={{70,88},{80,88},{80,
          78},{78,78},{78,70},{82,70}}, color={255,0,255}));
  connect(intLesEquThr1.y, and2.u2)
    annotation (Line(points={{76,52},{82,52},{82,62}}, color={255,0,255}));
  connect(and2.y, intSwi.u2)
    annotation (Line(points={{106,70},{120,70}}, color={255,0,255}));
  connect(conInt.y, intSwi.u1) annotation (Line(points={{104,114},{120,114},{
          120,78}}, color={255,127,0}));
  connect(booToInt.y, intSwi.u3) annotation (Line(points={{140,-6},{148,-6},{
          148,52},{120,52},{120,62}}, color={255,127,0}));
  connect(intSwi.y, ySysHeaCooMod) annotation (Line(points={{144,70},{154,70},{
          154,0},{180,0}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{160,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
            100}})));
end SystemThermalMode;
