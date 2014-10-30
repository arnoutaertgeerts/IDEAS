within IDEAS.DistrictHeating.Production;
model GenericModulatingProduction
  "A production model which is based on performance tables for different modulation steps"
  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeater(redeclare
      HeatSources.GenericModulatingHeatSource heatSource(redeclare
        Data.GenericBoiler productionData=productionData,
         numberOfModulationSteps=productionData.numberOfModulationSteps,
         QNom=QNom,
         UALoss=UALoss,
         TEnvironment=heatPort.T,
         THxIn=Tin.T,
         hIn=inStream(port_a.h_outflow),
         m_flowHx=port_a.m_flow,
         TSet=TSet,
         redeclare package Medium = Medium));

  //Variables
  Real eta "Instantaneous efficiency of the boiler (higher heating value)";

  //Components

  replaceable BaseClasses.PartialGenericModulatingData productionData constrainedby
    BaseClasses.PartialGenericModulatingData
    "Production data for the modulating heat source" annotation (
    Placement(transformation(extent={{-80,60},{-60,80}})),
    choicesAllMatching=true,
    Dialog(group="Data file with modulation data"));
equation
  PEl = 7 + heatSource.modulation/100*(33 - 7);
  PFuel = heatSource.PFuel;
  eta = heatSource.eta;

  connect(heatSource.heatPort, pipe_HeatPort.heatPort) annotation (Line(
      points={{-20,70},{28,70},{28,-6}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,120}}),       graphics));
end GenericModulatingProduction;
