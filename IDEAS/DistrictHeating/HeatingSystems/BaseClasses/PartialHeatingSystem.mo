within IDEAS.DistrictHeating.HeatingSystems.BaseClasses;
partial model PartialHeatingSystem
  "Partial for hydraulic heating system coupled to substation of district heating system"

  extends IDEAS.Interfaces.BaseClasses.HeatingSystemDH(
    isHea = true,
    isCoo = false,
    nConvPorts = nZones,
    nRadPorts = nZones,
    nTemSen = nZones,
    nEmbPorts=nZones,
    m_flow_nominal=sum(m_flow_zone),
    nLoads=1,
    nZones=1);

  // --- Parameter: General parameters for the design (nominal) conditions and heat curve
  parameter Modelica.SIunits.Power[nZones] QNom(each min=0) = ones(nZones)*5000
    "Nominal power, can be seen as the max power of the emission system per zone";
  parameter Boolean minSup=true
    "true to limit the supply temperature on the lower side";
    parameter Modelica.SIunits.Temperature TSupMin=273.15 + 30
    "Minimum supply temperature if enabled";
  parameter Modelica.SIunits.Temperature TSupNom=273.15 + 45
    "Nominal supply temperature";
  parameter Modelica.SIunits.TemperatureDifference dTSupRetNom=10
    "Nominal DT in the heating system";
  parameter Modelica.SIunits.Temperature[nZones] TRoomNom={294.15 for i in 1:
      nZones} "Nominal room temperature";
  parameter Modelica.SIunits.TemperatureDifference corFac_val = 0
    "correction term for TSet of the heating curve";
  parameter Modelica.SIunits.Time timeFilter=43200
    "Time constant for the filter of ambient temperature for computation of heating curve";
  final parameter Modelica.SIunits.MassFlowRate[nZones] m_flow_zone = QNom/(4180.6*dTSupRetNom)
    "Nominal mass flow rates";

  replaceable HydraulicCircuits.BaseClasses.HydraulicCircuitPartial hydraulicCircuitSH[nZones](
    redeclare final package Medium1 = Medium,
    redeclare final package Medium2 = Medium,
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=m_flow_nominal) constrainedby
    HydraulicCircuits.BaseClasses.HydraulicCircuitPartial annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-82,36})),choicesAllMatching=true);

  HydraulicCircuits.ZoneSplitter zoneSplitter(
    redeclare final package Medium = Medium,
    n=nZones,
    m_flow_nominal=sum(m_flow_zone),
    V=sum(m_flow_zone)*30/1000)
    annotation (Placement(transformation(extent={{-92,0},{-72,20}})));

  replaceable Fluid.HeatExchangers.Radiators.Radiator emission[nZones](
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-106,60},{-126,80}})));

  Fluid.FixedResistances.Pipe_Insulated pipeSupply[nZones](
    redeclare package Medium=Medium,
    m_flow_nominal=m_flow_zone,
    m=1,
    UA=10)
    annotation (Placement(
        transformation(
        extent={{-10,-4},{10,4}},
        rotation=90,
        origin={-88,60})));
  Fluid.FixedResistances.Pipe_Insulated pipeReturn[nZones](
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_zone,
    m=1,
    UA=10)
    annotation (Placement(
        transformation(
        extent={{10,-4},{-10,4}},
        rotation=90,
        origin={-76,72})));

  replaceable Control.PartialControl controlSH[nZones]
    annotation (Placement(transformation(extent={{-126,26},{-106,46}})));
equation
  connect(zoneSplitter.port_bN, hydraulicCircuitSH.port_a1) annotation (
      Line(
      points={{-88,20.2},{-88,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(zoneSplitter.port_aN, hydraulicCircuitSH.port_b2) annotation (
      Line(
      points={{-76,20.2},{-76,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hydraulicCircuitSH.port_b1, pipeSupply.port_a) annotation (Line(
      points={{-88,46},{-88,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hydraulicCircuitSH.port_a2, pipeReturn.port_b) annotation (Line(
      points={{-76,46},{-76,62}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeSupply.port_b, emission.port_a) annotation (Line(
      points={{-88,70},{-106,70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(emission.port_b, pipeReturn.port_a) annotation (Line(
      points={{-126,70},{-136,70},{-136,90},{-76,90},{-76,82}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(emission.heatPortCon, heatPortCon) annotation (Line(
      points={{-121,80},{-120,80},{-120,88},{-176,88},{-176,20},{-200,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(controlSH.y, hydraulicCircuitSH.u) annotation (Line(
      points={{-105.2,36},{-93.4,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(emission.heatPortRad, heatPortRad) annotation (Line(
      points={{-125,80},{-166,80},{-166,-20},{-200,-20}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end PartialHeatingSystem;
