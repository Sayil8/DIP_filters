unit varios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, math;

//tipos a manejar por los procedimientos
type
  matrgb= array of array of array of byte;
  histro = array of byte;


  //procedimiento

  procedure promedio(al, an: integer; var m:matrgb);
  procedure negativo(al, an: integer; var m:matrgb);
  procedure negativoR(al,an: integer; var m:matrgb);
  procedure negativoG(al,an: integer; var m:matrgb);
  procedure negativoB(al,an: integer; var m:matrgb);
  procedure grisesuno(al, an: integer; var m:matrgb);
  procedure grisesprom(al, an: integer; var m:matrgb);
  procedure binarizacion(al, an: integer; var m:matrgb);
  procedure gama(al, an: integer; var m:matrgb);

  procedure histogramas(al, an:integer; var m: matrgb; var hr: histro);

  var

    umbral : byte;



implementation
//codificacion de procedimientos

procedure promedio (al, an: integer; var m:matrgb);
var
   i,j : integer;
   suma,tamano,prom : real;

  begin
       suma:= 0;
     tamano:= al * an;
     grisesprom(al,an,m);

     for i:=0 to al-1 do begin
         for j:=0 to an-1 do begin
               suma:= suma + m[i,j,0];
         end;
     end;
     prom := suma/tamano;
     umbral := round(prom);
  end ;


procedure negativoR(al,an : integer; var m:matrgb);
var
  i,j : integer;

begin
     for i:=0 to al-1 do begin
          for j:=0 to an-1 do begin
              m[i,j,0]:=255-m[i,j,0];
          end;
        end;
end;
procedure negativoG(al,an : integer; var m:matrgb);
var
  i,j : integer;

begin
     for i:=0 to al-1 do begin
          for j:=0 to an-1 do begin
              //segmentacion no intensionada
              //m[i,j,0]:=255-m[i,j,1];
              //m[i,j,2]:=255-m[i,j,1];
              m[i,j,1]:=255-m[i,j,1];
          end;
        end;
end;
procedure negativoB(al,an : integer; var m:matrgb);
var
  i,j : integer;

begin
     for i:=0 to al-1 do begin
          for j:=0 to an-1 do begin
              m[i,j,2]:=255-m[i,j,2];
          end;
        end;
end;


procedure negativo(al,an: integer; var m:matrgb);
var
  i,j : integer;
  k : byte;
begin
    for i:=0 to al-1 do begin
      for j:=0 to an-1 do begin
               for k:=0 to 2 do begin
                        m[i,j,k]:=255-m[i,j,k];
                        end;
          end;
        end;

end;
procedure grisesuno(al, an: integer; var m:matrgb);
var
  i,j : integer;

begin
      for i:=0 to al-1 do begin
      for j:=0 to an-1 do begin
                        m[i,j,0]:=m[i,j,2];
                        m[i,j,1]:=m[i,j,2];

          end;
        end;
end;
procedure grisesprom(al, an: integer; var m:matrgb);
var
  i,j: integer;
  k: byte;
  suma : real;
begin
          for i:=0 to al-1 do begin
              for j:=0 to an-1 do begin
                        suma:= (m[i,j,0] + m[i,j,1] + m[i,j,2])/3;
                        k:=round(suma);
                        m[i,j,0] := k;
                        m[i,j,1] := k;
                        m[i,j,2] := k;

              end;
          end;
end;
procedure binarizacion(al, an: integer; var m:matrgb);
var
  i,j: integer;
  k : byte;


begin


      for i:=0 to al-1 do begin
         for j:=0 to an-1 do begin
             for k:=0 to 2 do begin
                if m[i,j,k] < umbral then
                      m[i,j,k]:= 0
                else
                       m[i,j,k]:= 255 ;


             end;
         end;
     end;


end;
procedure gama(al, an: integer; var m:matrgb);
var
  i,j,k: integer;
  g : real;
  max : byte;
begin
         //variable g opera sobre la cantidad de luminicencia
        g:=20;
         max :=255 ;
        for i:=0 to al-1 do begin
         for j:=0 to an-1 do begin
             for k:=0 to 2 do begin
                  m[i,j,k] :=  round(max*power(m[i,j,k]/255,g));

             end;
         end;
     end;

end;

procedure histogramas(al, an:integer; var m: matrgb; var hr:histro);
var
  i,j: integer;
  x : byte;


begin


    //limpiar vector
  for i:=0 to 255 do begin
     hr[i] := 0;
  end;

  //llenar vector
 for i:=0 to al-1 do begin
     for j:=0 to an-1 do begin
        //x := m[i,j,0];
        //inc(hr[m[i,j,0]]);
     end;
  end;





end;

end.
