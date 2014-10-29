within IDEAS.DistrictHeating.Production;
model Boiler
  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeater(redeclare
      HeatSources.ModulatingHeatSource heatSource(redeclare
        IDEAS.DistrictHeating.Production.Data.Boiler productionData,
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

equation
  PEl = 7 + heatSource.modulation/100*(33 - 7);
  PFuel = heatSource.PFuel;
  eta = heatSource.eta;

  connect(heatSource.heatPort, pipe_HeatPort.heatPort) annotation (Line(
      points={{-50,76},{-22,76},{-22,76},{28,76},{28,-6}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,120}}),       graphics));
end Boiler;
