within hvac_storage_building.PCM.Data;
record SunampQ6HeatExchanger
  extends Modelica.Icons.Record;
  parameter Modelica.Units.SI.Energy Tes_nominal = 7*3600000 "Design SU-58 Q6 capacity (factor * 1kWh)" annotation(Dialog(group="Sizing"));
  parameter Integer UniQ = max(1,integer(TesScale*6)) "Sunamp naming convention used to specify number of tubes per bank in heat exchanger" annotation(Dialog(group="Sizing"));
  parameter Modelica.Units.SI.Energy Tes_Q6 = PCM.LHea*PCM.d*PCM.x*Aorig "Actual SU-58 Q6 capacity (factor * 1kWh)" annotation(Dialog(group="Sizing"));
  parameter Modelica.Units.SI.DimensionlessRatio TesScale = Tes_nominal/Tes_Q6 "Scale factor for Sunamp PCM HX size" annotation(Dialog(group="Sizing"));
  parameter Modelica.Units.SI.Energy Tes_tube = Tes_Q6/36 "Energy per tube in UniQ" annotation(Dialog(group="Sizing"));
  parameter Modelica.Units.SI.Energy Tes_actual = Tes_tube*Ntubes "Total energy in TES" annotation(Dialog(group="Sizing"));
  parameter Modelica.Units.SI.Length D = 0.485 "Depth of finned tube heat exchanger"
                                                                                    annotation(Dialog(group="Heat Exchanger"));
  parameter Modelica.Units.SI.Length W = 0.335 "Width of finned tube heat exchanger"
                                                                                    annotation(Dialog(group="Heat Exchanger"));
  parameter Modelica.Units.SI.Length H = TesScale*0.365 "Height of finned tube heat exchanger"
                                                                                              annotation(Dialog(group="Heat Exchanger"));
  parameter Modelica.Units.SI.Length Horig = 0.365 "Original height of finned tube heat exchanger" annotation(Dialog(group="Heat Exchanger"));
  parameter Modelica.Units.SI.MacroscopicCrossSection Nfins_meter = 14*39.3701 "Number of fins per meter"
                                                                                                         annotation(Dialog(group="Fins"));
  parameter Integer Nfins = integer(Nfins_meter*D) "Number of fins in heat exchanger"
                                                                                     annotation(Dialog(group="Fins"));
  parameter Modelica.Units.SI.Length t_fin = 0.00012 "Thickness of each fin"
                                                                            annotation(Dialog(group="Fins"));
  parameter Modelica.Units.SI.Length tfins = t_fin*Nfins "Total thickness of all fins"
                                                                                      annotation(Dialog(group="Fins"));
  parameter Modelica.Units.SI.Length sfin = 1/Nfins_meter-t_fin "spacing between fins"
                                                                                      annotation(Dialog(group="Fins"));
  parameter Modelica.Units.SI.Length xfin = ((H*W)/(di*3.14159*Ntubes)) "fin heat transfer area per unit length"
                                                                                                                annotation(Dialog(group="Fins"));
  parameter Integer Ntubebanks = 6 "Number of tube banks in heat exchanger"
                                                                           annotation(Dialog(group="Tubes"));
  parameter Integer Ntubes_bank = UniQ "Number of tubes per bank in heat exchanger"
                                                                                   annotation(Dialog(group="Tubes"));
  parameter Integer Ntubes = Ntubebanks*Ntubes_bank "Number of tubes in heat exchanger"
                                                                                       annotation(Dialog(group="Tubes"));
  parameter Integer NLPC = integer(Ntubes*(1/3)) "Number of LPC tubes in heat exchanger"
                                                                                        annotation(Dialog(group="Tubes"));
  parameter Integer NHPC = integer(Ntubes*(2/3)) "Number of HPC tubes in heat exchanger"
                                                                                        annotation(Dialog(group="Tubes"));
  parameter Modelica.Units.SI.Length do = 0.0045 "Outer diameter of tube in heat exchanger"
                                                                                           annotation(Dialog(group="Tubes"));
  parameter Modelica.Units.SI.Length di = 0.00405 "Inner diameter of tube in heat exchanger"
                                                                                            annotation(Dialog(group="Tubes"));
  parameter Modelica.Units.SI.DimensionlessRatio ReLPC = 4*QLPC/(3.14159*di*nuw) "Reynolds number of LPC"
                                                                                                         annotation(Dialog(group="Convection Correlation"));
  parameter Modelica.Units.SI.DimensionlessRatio ReHPC = 4*QHPC/(3.14159*di*nuw) "Reynolds number of HPC"
                                                                                                         annotation(Dialog(group="Convection Correlation"));
  parameter Modelica.Units.SI.DimensionlessRatio Prw = 7.56 "Prandtl number of working fluid"
                                                                                             annotation(Dialog(group="Convection Correlation"));
  parameter Modelica.Units.SI.ThermalConductivity kw = 0.598 "Thermal conductivity of working fluid"
                                                                                                    annotation(Dialog(group="Convection Correlation"));
  parameter Modelica.Units.SI.DynamicViscosity muw = 8.9e-4 "Dynamic viscosity of working fluid" annotation(Dialog(group="Convection Correlation"));
  parameter Modelica.Units.SI.KinematicViscosity nuw = 8.9e-7 "Kinematic viscosity of working fluid" annotation(Dialog(group="Convection Correlation"));
  parameter Modelica.Units.SI.VolumeFlowRate QLPC = 12/((NLPC/Ntubes_bank)*60000) "Volumetric flow rate of working fluid in one LPC tube bank"
                                                                                                                                              annotation(Dialog(group="Convection Correlation"));
  parameter Modelica.Units.SI.VolumeFlowRate QHPC = 12/((NHPC/Ntubes_bank)*60000) "Volumetric flow rate of working fluid in one HPC tube bank"
                                                                                                                                              annotation(Dialog(group="Convection Correlation"));
  parameter Modelica.Units.SI.PressureDifference dp1_nominal = TesScale*9339 "Pressure drop in HPC" annotation(Dialog(group="Fluid Flow"));
  parameter Modelica.Units.SI.PressureDifference dp2_nominal = TesScale*32914 "Pressure drop in LPC" annotation(Dialog(group="Fluid Flow"));
  parameter Modelica.Units.SI.Time t_res = TesScale*20 "Residence time in TES" annotation(Dialog(group="Fluid Flow"));
  parameter Modelica.Units.SI.Area A_tubeLPC = di*3.14159*NLPC*D "Area of tubes in LPC"
                                                                                       annotation(Dialog(group="Tubes"));
  parameter Modelica.Units.SI.Area A_tubeHPC = di*3.14159*NHPC*D "Area of tubes in HPC"
                                                                                       annotation(Dialog(group="Tubes"));
  parameter Modelica.Units.SI.Area A_fin = do*3.14159*Ntubes*tfins "Area of fins"
                                                                                 annotation(Dialog(group="Fins"));
  parameter Modelica.Units.SI.Area A_pcm=(Nfins*2*W*H - 3.14159*(do/2)^2*Ntubes) + do*3.14159*Ntubes*(D-tfins) "Area of pcm"
                                                                                                                            annotation(Dialog(group="PCM"));
  parameter Modelica.Units.SI.Area Aorig= (Nfins*2*W*Horig - 3.14159*(do/2)^2*36) + do*3.14159*36*(D-tfins) "Area of pcm of Q6"
                                                                                                                               annotation(Dialog(group="PCM"));
  replaceable parameter
    Buildings.HeatTransfer.Data.SolidsPCM.Generic PCM(x=sfin, k= 1.51, c=3150, d=1360, LHea=226000, TSol=273.15 + 55, TLiq=273.15 + 59)  "SAT PCM material record"
                                                                                                                                                                  annotation(Dialog(group="Materials"));
  replaceable parameter
    Buildings.HeatTransfer.Data.Solids.Generic Aluminum(x=t_fin, k=235, c=904, d=2700) "Aluminum fin material record"
                                                                                                                     annotation(Dialog(group="Materials"));
  replaceable parameter
    Buildings.HeatTransfer.Data.Solids.Generic Copper(x=(do-di), k=400, c=384, d=8960) "Copper tube material record"
                                                                                                                    annotation(Dialog(group="Materials"));
end SunampQ6HeatExchanger;
