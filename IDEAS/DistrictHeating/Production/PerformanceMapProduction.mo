within IDEAS.DistrictHeating.Production;
model PerformanceMapProduction "Production model based on performance maps"

  extends BaseClasses.PartialHeater(redeclare HeatSources.PerformanceMap
      heatSource(
      redeclare package Medium = Medium,
      QNom=QNom,
      data=data,
      UALoss=UALoss));

equation
  PEl = 7 + heatSource.modulation/100*(33 - 7);
  PFuel = heatSource.PFuel;

 annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}), graphics));
end PerformanceMapProduction;
