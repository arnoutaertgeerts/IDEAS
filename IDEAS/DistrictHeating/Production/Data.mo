within IDEAS.DistrictHeating.Production;
package Data "Performance table data for production components"
  record Boiler "Boiler with 6 modulation steps"
    extends
      IDEAS.DistrictHeating.Production.Data.BaseClasses.PartialModulatingData(
      eta100=
        [0, 100, 400, 700, 1000, 1300; 20.0, 0.9015, 0.9441, 0.9599, 0.9691,
          0.9753; 30.0, 0.8824, 0.9184, 0.9324, 0.941, 0.9471; 40.0, 0.8736,
          0.8909, 0.902, 0.9092, 0.9143; 50.0, 0.8676, 0.8731, 0.8741, 0.8746,
          0.8774; 60.0, 0.8, 0.867, 0.8681, 0.8686, 0.8689; 70.0, 0.8, 0.8609,
          0.8619, 0.8625, 0.8628; 80.0, 0.8, 0.8547, 0.8558, 0.8563, 0.8566],
      eta80=
        [0, 100, 400, 700, 1000, 1300; 20.0, 0.9015, 0.9441, 0.9599, 0.9691,
          0.9753; 30.0, 0.8824, 0.9184, 0.9324, 0.941, 0.9471; 40.0, 0.8736,
          0.8909, 0.902, 0.9092, 0.9143; 50.0, 0.8676, 0.8731, 0.8741, 0.8746,
          0.8774; 60.0, 0.8, 0.867, 0.8681, 0.8686, 0.8689; 70.0, 0.8, 0.8609,
          0.8619, 0.8625, 0.8628; 80.0, 0.8, 0.8547, 0.8558, 0.8563, 0.8566],
      eta60=
        [0, 100, 400, 700, 1000, 1300; 20.0, 0.9349, 0.9759, 0.9879, 0.9941,
          0.998; 30.0, 0.9096, 0.9471, 0.9595, 0.9664, 0.9709; 40.0, 0.8831,
          0.9136, 0.9247, 0.9313, 0.9357; 50.0, 0.8701, 0.8759, 0.8838, 0.8887,
          0.8921; 60.0, 0.8634, 0.8666, 0.8672, 0.8675, 0.8677; 70.0, 0.8498,
          0.8599, 0.8605, 0.8608, 0.861; 80.0, 0.8488, 0.8532, 0.8538, 0.8541,
          0.8543],
      eta40=
        [0, 100, 400, 700, 1000, 1300; 20.0, 0.9624, 0.9947, 0.9985, 0.9989,
          0.999; 30.0, 0.9333, 0.9661, 0.9756, 0.9803, 0.9833; 40.0, 0.901,
          0.9306, 0.94, 0.9451, 0.9485; 50.0, 0.8699, 0.8871, 0.8946, 0.8989,
          0.9018; 60.0, 0.8626, 0.8647, 0.8651, 0.8653, 0.8655; 70.0, 0.8553,
          0.8573, 0.8577, 0.8579, 0.8581; 80.0, 0.8479, 0.8499, 0.8503, 0.8505,
          0.8506],
      eta20=
        [0, 100, 400, 700, 1000, 1300; 20.0, 0.9969, 0.9987, 0.999, 0.999,
          0.999; 30.0, 0.9671, 0.9859, 0.99, 0.9921, 0.9934; 40.0, 0.9293, 0.9498,
          0.9549, 0.9575, 0.9592; 50.0, 0.8831, 0.9003, 0.9056, 0.9083, 0.9101;
          60.0, 0.8562, 0.857, 0.8575, 0.8576, 0.8577; 70.0, 0.8398, 0.8479,
          0.8481, 0.8482, 0.8483; 80.0, 0.8374, 0.8384, 0.8386, 0.8387, 0.8388],
       QNom0=10100,
       etaNom=0.922,
       modulationMin=10,
       modulationStart=20,
       TMax=273.15+80,
       TMin=273.15+20);

  end Boiler;

  package BaseClasses
    partial record PartialModulatingData
      "Partial for a heat source data record which holds data of 6 modulation steps"
      extends Modelica.Icons.Record;

      parameter Real[:,:] eta100;
      parameter Real[:,:] eta80;
      parameter Real[:,:] eta60;
      parameter Real[:,:] eta40;
      parameter Real[:,:] eta20;

      final parameter Modelica.SIunits.Power QNom0
        "Nominal power of the boiler from which the power data are used in this model";
      constant Real etaNom
        "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
      parameter Real modulationMin(max=29) "Minimal modulation percentage";
      parameter Real modulationStart(min=min(30, modulationMin + 5))
        "Min estimated modulation level required for start of the heat source";
      parameter Modelica.SIunits.Temperature TMax
        "Maximum set point temperature";
      parameter Modelica.SIunits.Temperature TMin;

    end PartialModulatingData;
  end BaseClasses;
end Data;
