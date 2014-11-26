within IDEAS.DistrictHeating.HeatingSystems;
partial model PartialWithBaseCircuits
  "Partial for hydraulic heating system coupled to substation of district heating system"
  replaceable package Medium =
    Modelica.Media.Water.ConstantPropertyLiquidWater;
  extends IDEAS.Interfaces.BaseClasses.HeatingSystem(
    isHea = true,
    isCoo = false,
    nConvPorts = nZones,
    nRadPorts = nZones,
    nTemSen = nZones,
    nEmbPorts=nZones,
    nLoads=1,
    nZones=1);
  // --- Paramter: General parameters for the design (nominal) conditions and heat curve
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
  final parameter Modelica.SIunits.MassFlowRate[nZones] m_flow_nominal = QNom/(4180.6*dTSupRetNom)
    "Nominal mass flow rates";
  // --- production components of hydraulic circuit
  // --- distribution components of hydraulic circuit

  // --- emission components of hydraulic circuit
  // --- boundaries
  // --- controllers
  // --- Interface
  Modelica.Blocks.Interfaces.RealInput TSet[nZones](    final quantity="ThermodynamicTemperature",unit="K",displayUnit="degC")
    "Set point temperature for the zones" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-180,-114}),
                          iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=90,
        origin={-2,-104})));
  // --- Sensors

equation
  // connections that are function of the number of circuits
  for i in 1:nZones loop
  end for;

  // general connections for any configuration


  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end PartialWithBaseCircuits;
