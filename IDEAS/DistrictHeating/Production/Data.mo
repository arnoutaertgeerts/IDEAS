within IDEAS.DistrictHeating.Production;
package Data "Performance table data for production components"

  annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          fillPattern=FillPattern.None,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          extent={{-76,-26},{80,-76}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,24},{80,-26}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,74},{80,24}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-28,74},{-28,-76}},
          color={95,95,95}),
        Line(
          points={{24,74},{24,-76}},
          color={95,95,95})}));
  package PerformanceMaps
    record Boiler "A performance map for a Boiler"

      extends
        IDEAS.DistrictHeating.Production.BaseClasses.PartialPerformanceMap(
         QNomRef=10100,
         etaRef=0.922,
         modulationMin=10,
         modulationStart=20,
         TMax=273.15+80,
         TMin=273.15+20,
         numberOfModulations=6,
         performanceMap=
          {
          IDEAS.Utilities.Tables.Plane(height=0, curve=
          [0, 100, 400, 700, 1000, 1300; 20.0, 0, 0, 0, 0,
              0; 30.0, 0, 0, 0, 0, 0; 40.0, 0, 0,
              0, 0, 0; 50.0, 0, 0, 0, 0, 0;
              60.0, 0, 0, 0, 0, 0; 70.0, 0, 0,
              0, 0, 0; 80.0, 0, 0, 0, 0, 0]),
          IDEAS.Utilities.Tables.Plane(height=20, curve=
          [0, 100, 400, 700, 1000, 1300; 20.0, 0.9969, 0.9987, 0.999, 0.999,
              0.999; 30.0, 0.9671, 0.9859, 0.99, 0.9921, 0.9934; 40.0, 0.9293, 0.9498,
              0.9549, 0.9575, 0.9592; 50.0, 0.8831, 0.9003, 0.9056, 0.9083, 0.9101;
              60.0, 0.8562, 0.857, 0.8575, 0.8576, 0.8577; 70.0, 0.8398, 0.8479,
              0.8481, 0.8482, 0.8483; 80.0, 0.8374, 0.8384, 0.8386, 0.8387, 0.8388]),
          IDEAS.Utilities.Tables.Plane(height=40, curve=
          [0, 100, 400, 700, 1000, 1300; 20.0, 0.9624, 0.9947, 0.9985, 0.9989,
              0.999; 30.0, 0.9333, 0.9661, 0.9756, 0.9803, 0.9833; 40.0, 0.901,
              0.9306, 0.94, 0.9451, 0.9485; 50.0, 0.8699, 0.8871, 0.8946, 0.8989,
              0.9018; 60.0, 0.8626, 0.8647, 0.8651, 0.8653, 0.8655; 70.0, 0.8553,
              0.8573, 0.8577, 0.8579, 0.8581; 80.0, 0.8479, 0.8499, 0.8503, 0.8505,
              0.8506]),
          IDEAS.Utilities.Tables.Plane(height=60, curve=
          [0, 100, 400, 700, 1000, 1300; 20.0, 0.9349, 0.9759, 0.9879, 0.9941,
              0.998; 30.0, 0.9096, 0.9471, 0.9595, 0.9664, 0.9709; 40.0, 0.8831,
              0.9136, 0.9247, 0.9313, 0.9357; 50.0, 0.8701, 0.8759, 0.8838, 0.8887,
              0.8921; 60.0, 0.8634, 0.8666, 0.8672, 0.8675, 0.8677; 70.0, 0.8498,
              0.8599, 0.8605, 0.8608, 0.861; 80.0, 0.8488, 0.8532, 0.8538, 0.8541,
              0.8543]),
          IDEAS.Utilities.Tables.Plane(height=80, curve=
          [0, 100, 400, 700, 1000, 1300; 20.0, 0.9015, 0.9441, 0.9599, 0.9691,
              0.9753; 30.0, 0.8824, 0.9184, 0.9324, 0.941, 0.9471; 40.0, 0.8736,
              0.8909, 0.902, 0.9092, 0.9143; 50.0, 0.8676, 0.8731, 0.8741, 0.8746,
              0.8774; 60.0, 0.8, 0.867, 0.8681, 0.8686, 0.8689; 70.0, 0.8, 0.8609,
              0.8619, 0.8625, 0.8628; 80.0, 0.8, 0.8547, 0.8558, 0.8563, 0.8566]),
          IDEAS.Utilities.Tables.Plane(height=100, curve=
           [0, 100, 400, 700, 1000, 1300; 20.0, 0.9015, 0.9441, 0.9599, 0.9691,
              0.9753; 30.0, 0.8824, 0.9184, 0.9324, 0.941, 0.9471; 40.0, 0.8736,
              0.8909, 0.902, 0.9092, 0.9143; 50.0, 0.8676, 0.8731, 0.8741, 0.8746,
              0.8774; 60.0, 0.8, 0.867, 0.8681, 0.8686, 0.8689; 70.0, 0.8, 0.8609,
              0.8619, 0.8625, 0.8628; 80.0, 0.8, 0.8547, 0.8558, 0.8563, 0.8566])});

    end Boiler;
  end PerformanceMaps;

  package HeatPumps
    record VitoCal300GBWS301dotA08
      "Viessmann Vitocal 300-G, type BW/BWS/BWC 301.A08 heat pump data"
      extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatPump(
        QNomRef=8000,
        cop={{0,268.15,273.15,275.15,283.15,288.15},{308.15,4.02,4.65,4.94,6.13,
            6.87},{318.15,3.02,3.45,3.69,4.66,5.27},{328.15,0,2.65,2.82,3.52,3.96},{
            333.15,0,0,2.44,3.06,3.45}},
        power={{0,268.15,273.15,275.15,283.15,288.15},{308.15,1710,1690,1690,1680,
            1670},{318.15,2170,2150,2140,2100,2080},{328.15,0,2690,2680,2630,2600},{
            333.15,0,0,2950,2920,2900}});
      annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
    end VitoCal300GBWS301dotA08;

    record VitoCal300GBWS301dotA29
      "Viessmann Vitocal 300-G, type BW 301.A29 heat pump data"
      extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatPump(
        QNomRef=29000,
        cop={{0,263.15,268.15,273.15,275.15,283.15,288.15,293.15,298.15},{308.15,
            3.57,3.7,4.83,5.06,6,7.01,7.42,7.76},{318.15,2.67,3.13,3.6,3.82,4.69,5.36,
            5.97,6.62},{328.15,0,0,2.68,2.86,3.59,4.06,4.50,4.94},{333.15,0,0,0,2.34,
            3.11,3.54,3.89,4.26}},
        power={{0,263.15,268.15,273.15,275.15,283.15,288.15,298.15},{308.15,6460,
            6970,5960,6010,6200,6310,6864},{318.15,7965,7850,7790,7780,7730,7690,7627},
            {328.15,0,0,9750,9700,9500,9380,9237},{333.15,0,0,0,8600,10300,10390,10169}});
      annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
    end VitoCal300GBWS301dotA29;

    record VitoCal300GBWS301dotA45
      "Viessmann Vitocal 300-G, type BW 301.A45 heat pump data"
      extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatPump(
        QNomRef=45000,
        cop={{0,268.15,273.15,275.15,283.15,288.15,293.15,298.15},{308.15,3.9,4.6,
            4.78,5.5,6.49,6.98,7.40},{318.15,3.09,3.52,3.7,4.44,5.02,5.65,6.33},{328.15,
            0,2.76,2.81,3.4,3.86,4.36,4.81},{333.15,0,0,2.46,2.94,3.36,3.81,4.26}},
        power={{0,268.15,273.15,275.15,283.15,288.15,298.15},{308.15,9670,9280,9560,
            10700,10170,10190},{318.15,11640,11800,11810,11850,11850,12000},{328.15,
            0,14380,14310,14330,14230,14194},{333.15,0,0,15790,15750,15690,15484}});

      annotation (Documentation(revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Initial version
</li>
</ul>
</html>"));
    end VitoCal300GBWS301dotA45;
  end HeatPumps;
end Data;
