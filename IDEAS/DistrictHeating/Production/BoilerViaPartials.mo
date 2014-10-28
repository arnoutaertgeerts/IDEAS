within IDEAS.DistrictHeating.Production;
model BoilerViaPartials
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeater(redeclare
      Data.Boiler partialProdutionData);

equation
  connect(heatSource.heatPort, pipe_HeatPort.heatPort) annotation (Line(
      points={{-58,80},{28,80},{28,-6}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}), graphics));
end BoilerViaPartials;
