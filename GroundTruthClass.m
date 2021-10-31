
%
% Class to compute PR stats from algarithmic results vs anticipated results.
%
classdef GroundTruthClass  < handle

    methods (Static, Access = public)
       
      %% derive a class from the filename, for comparison against our calculations
      function derivedClass = deriveClassFromFilenameSimple(filename)
          chunk = split(filename, '_');
          derivedClass = string(chunk(1));
      end

      % Simple class = first number from filename classifier
      function derivedClass = deriveClassFromFilename(filename)
          chunk = split(filename, '_');
          derivedClass = string(chunk(1));
      end

      % Extended classifier, returning cow, sheep, grass, etc.
      function derivedClass = deriveClassFromFilenameEx(filename)
          chunk = split(filename, '_');
          first = string(chunk(1));
          second = string(chunk(2));
          switch first
              case '1'
                  derivedClass = GroundTruthClass.deriveClassRow1(second);
              case '2'
                  derivedClass = GroundTruthClass.deriveClassRow2(second);
              case '3'
                  derivedClass = GroundTruthClass.deriveClassRow3(second);
              case '3'
                  derivedClass = GroundTruthClass.deriveClassRow3(second);
              case '4'
                  derivedClass = GroundTruthClass.deriveClassRow4(second);
              case '5'
                  derivedClass = GroundTruthClass.deriveClassRow5(second);
              case '6'
                  derivedClass = GroundTruthClass.deriveClassRow6(second);
              case '7'
                  derivedClass = GroundTruthClass.deriveClassRow7(second);
              case '8'
                  derivedClass = GroundTruthClass.deriveClassRow8(second);
              case '9'
                  derivedClass = GroundTruthClass.deriveClassRow9(second);
              case '10'
                  derivedClass = GroundTruthClass.deriveClassRow10(second);
              case '11'
                  derivedClass = GroundTruthClass.deriveClassRow11(second);
              case '12'
                  derivedClass = GroundTruthClass.deriveClassRow12(second);
              case '13'
                  derivedClass = GroundTruthClass.deriveClassRow13(second);
              case '14'
                  derivedClass = GroundTruthClass.deriveClassRow14(second);
              case '15'
                  derivedClass = GroundTruthClass.deriveClassRow15(second);
              case '16'
                  derivedClass = GroundTruthClass.deriveClassRow16(second);
              case '17'
                  derivedClass = GroundTruthClass.deriveClassRow17(second);
              case '18'
                  derivedClass = GroundTruthClass.deriveClassRow18(second);
              case '19'
                  derivedClass = GroundTruthClass.deriveClassRow19(second);
              case '20'
                  derivedClass = GroundTruthClass.deriveClassRow20(second);
              otherwise
                  warning(['Unregognised filename ', filename]);
          end
      end
   end
   
   methods (Static, Access = private)

      %% Row 1/20 grass, cow, horse, sheep
      function derivedClass = deriveClassRow1(ix)
          switch ix
              case {'8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22'}
                  derivedClass =  'cow';
              case {'23', '24', '25'}
                  derivedClass =  'horse';
              case {'26', '27', '28', '29', '30'}
                  derivedClass =  'sheep';
              otherwise
                  derivedClass =  'grass';
          end
      end

      %%row 2/20 tree
      function derivedClass = deriveClassRow2(~)
        derivedClass = 'tree';
      end

      %%row 3/20 building
      function derivedClass = deriveClassRow3(~)
        derivedClass = 'building';
      end

      %%row 4/20 aeroplane
      function derivedClass = deriveClassRow4(~)
        derivedClass = 'aeroplane';
      end

      %%row 5/20 cow
      function derivedClass = deriveClassRow5(~)
        derivedClass = 'cow';
      end

      %%row 6/20 face
      function derivedClass = deriveClassRow6(~)
        derivedClass = 'face';
      end

      %%row 7/20 car
      function derivedClass = deriveClassRow7(~)
        derivedClass = 'car';
      end

      %%row 8/20 bike
      function derivedClass = deriveClassRow8(~)
        derivedClass = 'bike';
      end

      %%row 9/20 sheep
      function derivedClass = deriveClassRow9(~)
        derivedClass = 'sheep';
      end

      %%row 10/20 flower
      function derivedClass = deriveClassRow10(~)
        derivedClass = 'flower';
      end

      %%row 11/20 sign
      function derivedClass = deriveClassRow11(~)
        derivedClass = 'sign';
      end

      %%row 12/20 bird
      function derivedClass = deriveClassRow12(~)
        derivedClass = 'bird';
      end

      %%row 13/20 book
      function derivedClass = deriveClassRow13(~)
        derivedClass = 'book';
      end

      %%row 14/20 chair
      function derivedClass = deriveClassRow14(~)
        derivedClass = 'chair';
      end

      %%row 15/20 cat
      function derivedClass = deriveClassRow15(~)
        derivedClass = 'cat';
      end

      %%row 16/20 dog
      function derivedClass = deriveClassRow16(~)
        derivedClass = 'dog';
      end

      %%row 17/20
      function derivedClass = deriveClassRow17(~)
        derivedClass = 'road';
      end

      %%row 18/20
      function derivedClass = deriveClassRow18(ix)
          switch ix
              case {'1', '2', '4', '5', '8', '9', '12', '13' }
                  derivedClass =  'water';
              case {'25', '26'}
                  derivedClass =  'bird';
              case {'28', '29'}
                  derivedClass =  'building';
              otherwise
                  derivedClass = 'boat';
          end
      end

      %%row 19/20
      function derivedClass = deriveClassRow19(~)
        derivedClass = 'body';
      end

      %%row 20/20 water, boat, sky, ...
      function derivedClass = deriveClassRow20(ix)
          switch ix
              case {'1'}
                  derivedClass =  'water';
              case {'15'}
                  derivedClass =  'boat';
              case {'2', '4', '21'}
                  derivedClass =  'mountain';
              otherwise
                  derivedClass = 'water';
          end

      end

   end

end
