unit sourceImgcanvas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus, ExtDlgs, LCLintf, ComCtrls,dateutils,math, varios,Unit2,Unit3,Unit4, Unit5;

type

  { TForm1 }

  //tipos de dato

  matrgb= Array of Array of Array of byte;
  histro = array of byte;
  matconv = array [0..2,0..2] of integer;
  dilatacion = array [0..2,0..2] of integer;
  dilatacion1 = array [0..2,0..2] of integer;
  matusuario = array of array of integer;

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    StaticText1: TStaticText;
    StatusBar1: TStatusBar;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure EditXChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image2Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure ScrollBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StaticText1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

    procedure copiacanv(al, an: Integer; var m: matrgb); //matriz a canvas
    procedure copiamat(al,an: Integer); //canvas a matriz
    procedure copiamat1(al,an: Integer; var m: matrgb); //canvas a matriz

    procedure copiabmmat(al,an: integer; var m: matrgb; b:tbitmap);
    procedure copiamatbm(al,an: integer; m: matrgb; var b:tbitmap);

    procedure filtronegativo(al,an: integer; var m: matrgb);

    procedure histograma(al,an,tipo: integer; var m:matrgb; var v: histro);
    procedure desplazamiento(al,an: integer; var v: histro);
    procedure Burbuja(var vector: Array of Integer);
    procedure suavizadoProm ();
    procedure dilatacion(var m, mcv :matrgb;var vector: Array of Integer);
    procedure erosion(var m, mcv: matrgb; var vector:array of integer);

  end;
  const //constante
    masc : matconv = (
                      (-1,-2,-1),
                       (0,0,0),
                       (1,2,1)
                       );
    dil : dilatacion = (
                          (0,1,0),
                          (1,1,1),
                          (0,1,0)
                        );

var
  Form1: TForm1;
  mat,matI,auxM,auxmconv:matrgb; //mat[cx,cy,canal]
  vector : histro;
  alto, ancho: integer;
  Bmap: tbitmap;
  nomArch : string;
  matrizConvolucion : matusuario;

  inicio, final : tdatetime; //medir tiempo
  ini,fin :int64;

implementation

{$R *.lfm}

{ TForm1 }
procedure tform1.erosion(var m, mcv: matrgb; var vector:array of integer)  ;
var
     i,j,k,a,b,l: integer;
    max, pos : integer;
begin
      //aplicamos la erosion a la imagen
       for i:=1 to alto-2  do begin
      for j:=1 to ancho-2 do begin
          pos := 0;
          max := 0;
              for a:=-1 to 1 do begin
                         for b:=-1 to 1 do begin
                             vector[pos] := m[i+a,j+b,0] - dil[a+1,b+1];
                             inc(pos);
                         end;
              end;
              //valor maximo
              max:=vector[0];
              for l:=1 to 8 do begin
                  if vector[l] < max then
                     max:=vector[l];
              end;
             mcv[i,j,0] := max;
             mcv[i,j,1] := max;
             mcv[i,j,2] := max;


      end;
  end;
        for i:=0 to alto-1 do begin
           for j:=0 to ancho-1 do begin
               for k:=0 to 2 do begin
                   //mat[i,j,k] :=abs(matD[i,j,k] - matE[i,j,k]);
                   m[i,j,k] := mcv[i,j,k]
               end;
           end;

end;
end;
procedure tform1.dilatacion(var m, mcv :matrgb;var vector: Array of Integer);
var
    i,j,k,a,b,l: integer;
    max, pos : integer;

begin

     image1.picture.savetofile('temp.bmp');
     setlength(mcv,alto,ancho,3);

     //aplicamos dilatacion a la imagen
      for i:=1 to alto-2  do begin
      for j:=1 to ancho-2 do begin
          pos := 0;
          max := 0;
              for a:=-1 to 1 do begin
                         for b:=-1 to 1 do begin
                             vector[pos] := m[i+a,j+b,0] + dil[a+1,b+1];
                             inc(pos);
                         end;
              end;
              //valor maximo
              for l:=0 to 8 do begin
                  if vector[l] > max then
                     max:=vector[l];
              end;
             mcv[i,j,0] := max;
             mcv[i,j,1] := max;
             mcv[i,j,2] := max;


      end;
  end;
  end;

procedure tform1.suavizadoProm();
var
  i,j,k,a,b : integer;
  prom: integer;
  AUX: MATRGB;
begin
     image1.picture.savetofile('temp.bmp');
     setlength(AUX,alto,ancho,3);
     for i := 1 to ALTO-2 do begin
         for j := 1 to ANCHO-2 do begin
             for k := 0 to 2 do begin
             //Obtenemos los valores
        prom := 0;
        for a := -1 to 1 do begin
          for b := -1 to 1 do begin
            prom := MAT[i+a,b+j,k] + prom;
          end; //b
        end; //a
        //Asignamos al pivote
        prom := round(prom/9);
        AUX[i,j,k] := prom
      end; //k
    end; //j
  end; //i
   for i:=0 to alto-1 do begin
               for j:=0 to ancho -1 do begin
                   for k:=0 to 2 do begin
                       mat[i,j,k] := aux[i,j,k];
                       end;
               end;
   end;
  copiamat(alto,ancho);
end;

procedure tform1.Burbuja(var vector: Array of Integer);
var
  x,y: Integer;
  auxiliar: Integer;
begin
  //Ordenamos los valores
  for x := 1 to 8 do begin
    for y := 0 to 7 do begin
      if vector[y] > vector[y+1] then begin
        auxiliar := vector[y+1];
        vector[y+1] := vector[y];
        vector[y] := auxiliar;
      end;
    end; //y
  end; //x
end;
procedure tform1.desplazamiento(al,an: integer; var v: histro);
var
    x : byte  ;
    i ,j,max,escala,desp: integer;
begin

       form2.TrackBar1.position := umbral ;
       form2.ShowModal;

     if (form2.modalresult = mrok) then
     begin

          desp :=form2.valor;


      image2.canvas.Pen.color := clwhite;
      image2.canvas.rectangle(0,0,image2.Width,image2.height);

      for i:= 0 to 255 do begin
          vector[i] := vector[i]+desp;
          //if vector[i] > 255 then
            //vector[i]:= 255;
          //if vector[i] < 0 then
            //vector[i]:=0;
      end;
      //calculamos el maximo
       max := v[0];
      for i :=1 to 255 do begin
          if(v[i] > max) then begin
            max := v[i];
          end;
      end;
       escala := round((image2.Height-1)*(1-v[0]/max));
      image2.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image2.Height-1)*(1-v[i]/max));
           image2.Canvas.LineTo(i,image2.height);
            image2.Canvas.LineTo(i,escala);

       end;

     end;


end;




procedure tform1.histograma(al,an,tipo: integer; var m:matrgb; var v:histro);
var
  x : byte  ;
  i ,j,max,escala: integer;
begin
  //limpiamos y colocamos longitud


      image2.canvas.Pen.color := clwhite;
      image2.canvas.rectangle(0,0,image2.Width,image2.height);

      setLength(vector,256);
      //limpiamos el vector
      for i:= 0 to 255 do begin
          v[i] := 0;
      end;
      //llenamos el vectoor
      //preguntamos de que color se requiere el historgrama
      //canal intensidad
      if tipo = 0 then begin
         image2.Canvas.pen.color := clblack;
         for i:= 0 to al-1 do begin
          for j:= 0 to an-1 do begin
          inc(v[m[i,j,0]]);
          end;
         end;
      end;
      //canal 1
      if tipo = 1 then begin
         image2.Canvas.pen.color := clred;
         for i:= 0 to al-1 do begin
          for j:= 0 to an-1 do begin
          //m[i,j,0]:= m[i,j,0] +200;
          inc(v[m[i,j,0]]);
          end;
         end;
      end;
      //canal 2
      if  tipo = 2 then begin
         image2.Canvas.pen.color := clgreen;
         for i:= 0 to al-1 do begin
          for j:= 0 to an-1 do begin
          inc(v[m[i,j,1]]);
          end;
         end;
      end;
      //canal 3
      if tipo = 3 then  begin
         image2.Canvas.pen.color := clblue;
         for i:= 0 to al-1 do begin
          for j:= 0 to an-1 do begin
          inc(v[m[i,j,2]]);
          end;
         end;
      end;
      //calculamos el maximo
      max := v[0];
      for i :=1 to 255 do begin
          if(v[i] > max) then begin
            max := v[i];
          end;
      end;

      //dibujamos

      //encontramos escala
      escala := round((image2.Height-1)*(1-v[0]/max));
      image2.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image2.Height-1)*(1-v[i]/max));
           image2.Canvas.LineTo(i,image2.height);
            image2.Canvas.LineTo(i,escala);

       end;

end;

procedure  tform1.filtronegativo(al,an: integer; var m: matrgb);
var
  i,j: integer;

begin
     for i:=0 to al-1 do begin
         for j:=0 to an-1 do begin

             m[i,j,0]:= 255 - m[i,j,0];
            m[i,j,1]:= 255 - m[i,j,1];
            m[i,j,2]:= 255 - m[i,j,2];
         end;
     end;
end;

procedure tform1.copiamatbm(al,an: integer; m: matrgb; var b:tbitmap);
var
   i,j,k : Integer;
  p: pbyte;
begin
    for i:=0 to al-1 do begin
        b.BeginUpdate();
        //p:=b.scanline[i];

        b.EndUpdate();
        for j:=0 to an-1 do begin
            k:=3*j;
              p[k]:=m[i,j,0];
              p[k+1]:=m[i,j,1];
              p[k+2]:=m[i,j,2];


        end;
    end;
end;

procedure tform1.copiabmmat(al,an: integer; var m: matrgb; b:tbitmap);
var
  i,j,k : Integer;
  p: pbyte;
begin
      for i:=0 to al-1 do begin
          b.BeginUpdate();
            //p:=b.scanline[i];
            b.EndUpdate();
          for j:=0 to an-1 do begin
             k:=3*j;
             m[i,j,0]:=p[k+2];    //r
             m[i,j,1]:=p[k+1];       //g
             m[i,j,2]:=p[k];            //b

              end;
          end;
end;

procedure tform1.copiamat(al,an: Integer);

var
  i,j: Integer;
  cl: tcolor;

  begin
    for i:=0 to al-1 do begin
        for j:=0 to an-1 do begin
              cl:=RGB(Mat[i,j,0],Mat[i,j,1],Mat[i,j,2]);

              image1.canvas.pixels[j,i]:= cl;
        end;
    end;
  end;
procedure tform1.copiamat1(al,an: Integer;var m:matrgb);

var
  i,j: Integer;
  cl: tcolor;

  begin
    for i:=0 to al-1 do begin
        for j:=0 to an-1 do begin
              cl:=RGB(m[i,j,0],m[i,j,1],m[i,j,2]);

              image1.canvas.pixels[j,i]:= cl;
        end;
    end;
  end;
procedure tform1.copiacanv(al,an:Integer; var m:matrgb);

var

  i,j : Integer;
  cl: tcolor;

  begin
    for i:=0 to al-1 do begin
        for j:=0 to an-1 do begin
            cl:=Image1.Canvas.Pixels[j,i];
            m[i,j,0]:=GetRValue(cl);
            m[i,j,1]:=GetGValue(cl);
            m[i,j,2]:=GetBValue(cl);
        end;
    end;
  end;

procedure TForm1.MenuItem2Click(Sender: TObject);
     var
       i,j,k:integer;
begin
  If OpenPictureDialog1.Execute  then      //si se elige Abrir en el cuadro de dialogo "Abrir"
  begin
    //cargar y visualizar imagen en el Timage
    Image1.enabled:=true;
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    nomArch := openpicturedialog1.FileName;
    image1.picture.savetofile('temp.bmp');

    alto:=Image1.Height;
    ancho:=Image1.Width;
    statusbar1.panels[8].text:=inttostr(alto) + 'x' + inttostr(ancho);


    //copiar contenido


     //matriz original
    setLength(mat,alto,ancho,3);
    //matriz grises
    setLength(mati,alto,ancho,3);
    //matriz de respaldo
    setLength(auxm,alto,ancho,3);




    inicio:=now;
     copiacanv(alto,ancho,mat);
    final:=now;

    //copiar contenido matriz original a aux
    for i:=0 to alto-1 do begin
            for j:=0 to ancho-1 do begin
                for k:=0 to 2 do begin
                    auxm[i,j,k]:= mat[i,j,k];
                end;
            end;
     end;

    statusbar1.panels[10].text:=floattostr(millisecondsbetween(inicio,final));



  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
      If OpenPictureDialog1.Execute  then begin

        Image1.picture.Assign(bmap);
        bmap.LoadFromFile(openpicturedialog1.filename);
        alto:=bmap.height;
        ancho:=bmap.Width;

        if bmap.pixelformat<> pf24bit then
        begin
          bmap.pixelformat:=pf24bit;       // solo para scanline
        end;


         copiacanv(alto,ancho,mat);

    setLength(mat,alto,ancho,3);
    setLength(mati,alto,ancho,3);

    copiabmmat(alto,ancho,mat,bmap);

    image1.picture.assign(bmap);
      end;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  image1.picture.savetofile('temp.bmp');
  negativo(alto,ancho,mat);
  copiamat(alto,ancho);
  statusbar1.panels[12].text:='Negativo';

end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  image1.picture.savetofile('temp.bmp');
  negativoR(alto,ancho,mat);
  copiamat(alto,ancho);
  statusbar1.panels[12].text:='Negativo R';
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  image1.picture.savetofile('temp.bmp');
      negativoG(alto,ancho,mat);
      copiamat(alto,ancho);
      statusbar1.panels[12].text:='Negativo G';
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  image1.picture.savetofile('temp.bmp');
     negativoB(alto,ancho,mat);
     copiamat(alto,ancho);
     statusbar1.panels[12].text:='Negativo B';
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  image1.picture.savetofile('temp.bmp');
  grisesuno(alto,ancho,mat);
   copiamat(alto,ancho);
   statusbar1.panels[12].text:='Grises iguales';
end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin

end;

procedure TForm1.ScrollBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin


end;

procedure TForm1.StaticText1Click(Sender: TObject);
begin

end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
      Bmap:=tbitmap.Create;


      image2.canvas.Pen.color := clwhite;
      image2.canvas.rectangle(0,0,image2.Width,image2.height);
      trackbar1.position := 10;
      trackbar2.position := 20;
      trackbar3.position := 150;

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,j,k : integer;
begin
   if shift=[ssright] then  begin
        if radiobutton1.Checked then begin
           for i:=0 to alto-1 do begin
                 for j:=0 to ancho-1 do begin
                       for k:=0 to 2 do begin
                              matI[i,j,k] := mat[i,j,k];
                       end;
                 end;
               end;

           grisesprom(alto,ancho,mati);
           histograma(alto,ancho,0,mati,vector);
        end ;
        if radiobutton2.Checked then begin
           histograma(alto,ancho,1,mat,vector);
        end;
         if radiobutton3.Checked then begin
           histograma(alto,ancho,2,mat,vector);
        end;
         if radiobutton4.Checked then begin
           histograma(alto,ancho,3,mat,vector);
        end;
  end
end;

procedure TForm1.EditXChange(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  image1.picture.savetofile('temp.bmp');
  filtronegativo(alto,ancho,mat);

    copiamat(alto,ancho);
    statusbar1.panels[12].text:='Negativo';
end;

procedure TForm1.Button10Click(Sender: TObject);
//contraste
var
  i,j,k: Integer;
  posicion: Integer;
  alfa: Real;
begin
      image1.picture.savetofile('temp.bmp');
      posicion := TrackBar1.Position;
      case posicion of
    1: alfa := 0.001;
    2: alfa := 0.002;
    3: alfa := 0.003;
    4: alfa := 0.004;
    5: alfa := 0.005;
    6: alfa := 0.006;
    7: alfa := 0.007;
    8: alfa := 0.008;
    9: alfa := 0.009;
    10: alfa := 0.01;
    11: alfa := 0.02;
    12: alfa := 0.03;
    13: alfa := 0.04;
    14: alfa := 0.05;
    15: alfa := 0.1;
    end;
       for i := 0 to ALTO-1 do begin
    for j := 0 to ANCHO-1 do begin
      for k := 0 to 2 do begin
        MAT[i,j,k] := round((255/2)*(1+(tanh(alfa*(MAT[i,j,k]-(255/2))))));
      end; //k
    end; //j
  end; //i

        copiamat(alto,ancho);

end;

procedure TForm1.Button11Click(Sender: TObject);
//zoom out
var
  i,j,k: integer;
  a,b : integer;
  nal, nan, prom : integer;
  mzoom:matrgb;

begin
   image1.picture.savetofile('temp.bmp');
     //calculamos las nuevas medidad de la imagen y asignamos
      nal := alto div 2;
      nan := ancho div 2;
      prom := 0;
      b:=2;

      setLength(mzoom,nal,nan,3);

      //procesamos la imagen
      for i:=0 to nal-1 do begin
          for j:=0 to nan-1 do begin
                 for k:=0 to 2 do begin
                prom := (mat[i*b,j*b,k]+mat[i*b,(j*b)+1,k]+mat[(i*b)+1,j,k]+mat[(i*b)+1,(j*b)+1,k]);
                prom := round(prom/4);
                mzoom[i,j,k] := prom;
                 end;//k
          end;//j
      end; //i

      //asignamos las nuevas dimensiones y matriz

        //asignamos las nuevas dimensiones y nuevos datos
     alto := nal;
     ancho := nan;
      setlength(mat,alto,ancho,3);
     image1.Picture.Bitmap.SetSize(nan,nal);

     for i:=0 to alto-1 do begin
               for j:=0 to ancho -1 do begin
                   for k:=0 to 2 do begin
                       mat[i,j,k] := mzoom[i,j,k];
                       end;
                   end;
                   end;
     copiamat(alto,ancho);

end;

procedure TForm1.Button12Click(Sender: TObject);
//rotacion
var
  i,j,k: integer;
  mrot :matrgb;
  al, an,anc : integer;

begin
  image1.picture.savetofile('temp.bmp');

   al := ancho;
   an := alto;
    setlength(mrot,al,an,3);
    for i:=0 to alto-1 do begin
        for j:=0 to ancho-1 do begin
            for k:=0 to 2 do begin
                   anc := ancho-1-j;
                   mrot[anc,i,k]:=mat[i,j,k];
            end;
        end;
    end;

      //asignamos las nuevas dimensiones y matriz
      alto := al;
      ancho := an;
      setlength(mat,alto,ancho,3);
     image1.Picture.Bitmap.SetSize(an,al);
     for i:=0 to alto-1 do begin
               for j:=0 to ancho -1 do begin
                   for k:=0 to 2 do begin
                       mat[i,j,k] := mrot[i,j,k];
                       end;
                   end;
                   end;

      copiamat1(alto,ancho,mrot);

end;

procedure TForm1.Button13Click(Sender: TObject);
//rotacion -90
var
  i,j,k: integer;
  mrot :matrgb;
  al, an,anc : integer;
begin
   image1.picture.savetofile('temp.bmp');
   al := ancho;
   an := alto;
   setlength(mrot,al,an,3);
    for j:=0 to ancho-1 do begin
        for i:=0 to alto-1 do begin
            for k:=0 to 2 do begin
                   anc := alto-1-i;
                   mrot[j,anc,k]:=mat[i,j,k];
            end;
        end;
    end;

      //asignamos las nuevas dimensiones y matriz
       alto := al;
      ancho := an;
      setlength(mat,alto,ancho,3);
     image1.Picture.Bitmap.SetSize(an,al);
     for i:=0 to alto-1 do begin
               for j:=0 to ancho -1 do begin
                   for k:=0 to 2 do begin
                       mat[i,j,k] := mrot[i,j,k];
                       end;
                   end;
                   end;

      copiamat1(alto,ancho,mrot);

end;

procedure TForm1.Button14Click(Sender: TObject);
//segmentacion gris
var
  i,j,k : integer ;
  tol , tono: integer;
begin
  image1.picture.savetofile('temp.bmp');
      tol := trackbar2.position;
      tono := trackbar3.position;

      for i:=0 to alto-1 do begin
          for j:=0 to alto -1 do begin
              if (mat[i,j,0] > (tono + tol)) or (mat[i,j,0] < (tono - tol)) then begin
                     mat[i,j,0] := 255;
                     mat[i,j,1] := 255;
                     mat[i,j,2] := 255;

              end;
          end;
      end;
      copiamat(alto,ancho);
      statusbar1.panels[12].text:='segmentacion de grises';

end;

procedure TForm1.Button15Click(Sender: TObject);
//eliminar ojos rojos
var
  i,j,k : integer;
  prom : integer;
begin
  //recorremos toda la matriz en busca de rojos fuertes
   image1.picture.savetofile('temp.bmp');
   for i :=0 to alto-1 do begin
       for j:=0 to ancho-1 do begin
           if (mat[i,j,0] > mat[i,j,1]+mat[i,j,2]) then begin
              prom := mat[i,j,0] - (mat[i,j,1] + mat[i,j,2]);
              if prom > 20 then begin
                 mat[i,j,0] := 0;
              end;
           end;
       end;
   end;
   copiamat(alto,ancho);
end;

procedure TForm1.Button16Click(Sender: TObject);
//filtro propio
var
  i,j,k : integer;
  times : integer;
  coox,cooy,tono : integer;
  t : integer;
begin
   image1.picture.savetofile('temp.bmp');



     //recorremos la imagen y agregamos ruido

            times:=round(alto*ancho/10);
            randomize;
             t:=0;

             for i:=0 to times do begin


                  coox :=random(alto-5)+1;
                  cooy :=random(ancho-5)+1;
                  for k:=0 to 2 do begin
                      tono := round(mat[coox,cooy,k] * 1.9);
                      if tono > 255 then
                         tono:=255;

                      mat[coox,cooy,k] := tono;
                      mat[coox+1,cooy,k] := tono;
                      mat[coox+2,cooy,k] := tono;
                  end;

              end;

              //hacemos borrosa la imagen
              suavizadoprom();
                //oscurecemos la imagen
            for i:=0 to alto-1 do begin
                for j:=0 to ancho-1 do begin
                    for k:=0 to 2 do begin
                        mat[i,j,k] := round(mat[i,j,k] * 0.4);
                        end;

                end;
            end;
             //hacemos borrosa la imagen
              suavizadoprom();

          copiamat(alto,ancho);
end;

procedure TForm1.Button17Click(Sender: TObject);
//segmentacion de venas
var
    i,j,k,a,b,l: integer;
    umbral : integer;
    max, pos : integer;
     vec: Array[0..8] of Integer;
     matE,matD : matrgb;

begin
     image1.picture.savetofile('temp.bmp');
     setlength(matE,alto,ancho,3);
     setlength(matD,alto,ancho,3);
     dilatacion(mat, matE,vec);
     erosion(mat,matD,vec);
     erosion(mat,matD,vec);
     erosion(mat,matD,vec);
       erosion(mat,matD,vec);
     erosion(mat,matD,vec);
     erosion(mat,matD,vec);
     dilatacion(auxm, matE,vec);


       //aplicamos el gradiente morfologico entocnes restamos las dos matrizes
       for i:=0 to alto-1 do begin
           for j:=0 to ancho-1 do begin
               for k:=0 to 2 do begin
                   mat[i,j,k] :=abs(mat[i,j,k] - matE[i,j,k]) ;
               end;
           end;
       end;

       copiamat(alto,ancho);
end;

procedure TForm1.Button18Click(Sender: TObject);
//expansion automatica
var
    i,j,k : integer;
    veR: histro;
    veG: histro;
    veB: histro;
    veI: histro;
    sumatoria,factor : integer;
    cl : tcolor;

begin
      //calculamos el histograma de los tres canales

      setLength(veR,256);
      setLength(veG,256);
      setLength(veB,256);
      setLength(veI,256);

      sumatoria := 0;

      //obtenemos histograma color R y realizamos la sumatoria
      histograma(alto,ancho,1,mat,veI);

      for i:=0 to 255 do begin
          sumatoria := sumatoria + veI[i];
          veR[i] := round(sumatoria * (255 / (alto*ancho))) ;
      end;

      //color g
      histograma(alto,ancho,2,mat,veI);
      sumatoria := 0;
      for i:=0 to 255 do begin
          sumatoria := sumatoria + veI[i];
          veG[i] := round(sumatoria * (255 /(alto*ancho))) ;
      end;
        //color B
      histograma(alto,ancho,3,mat,veI);
      sumatoria := 0;
      for i:=0 to 255 do begin
          sumatoria := sumatoria + veI[i];
          veB[i] := round(sumatoria * (255 /(alto*ancho))) ;
      end;
      //actualizamos matriz con nuevos valores

      for i:= 0 to alto-1 do begin
          for j:= 0 to ancho-1 do begin
              cl:=Image1.Canvas.Pixels[j,i];
              mat[i,j,0] := veR[GetRvalue(cl)];
              mat[i,j,1] := veG[GetGvalue(cl)];
              mat[i,j,2] := veB[GetBvalue(cl)];
          end;
      end;
      //mostramos nueva matriz
      copiamat(alto,ancho);

end;

procedure TForm1.Button2Click(Sender: TObject);
//binarizacion
var
  cl1, cl2 : tcolor;
  i,j,k: integer;
begin
   image1.picture.savetofile('temp.bmp');
     promedio(alto,ancho,mat);
     form2.TrackBar1.position := umbral ;
     form2.ShowModal;

     if (form2.modalresult = mrok) then
     begin

          umbral :=form2.valor;
          cl1 :=form2.shape1.brush.color;
          cl2 :=form2.shape2.brush.color;



      for i:=0 to alto-1 do begin
         for j:=0 to ancho-1 do begin

                if mat[i,j,0] < umbral then BEGIN
                      mat[i,j,0]:= getRvalue(cl1) ;
                      mat[i,j,1]:= getGvalue(cl1)  ;
                      mat[i,j,2]:= getBvalue(cl1)
                end
                else  begin
                       mat[i,j,0]:= getRvalue(cl2) ;
                       mat[i,j,1]:= getGvalue(cl2) ;
                       mat[i,j,2]:= getbvalue(cl2) ;
                end;



         end;
     end;

          inicio:=now;
          copiamat(alto,ancho);
          final:=now;

          statusbar1.panels[10].text:=floattostr(millisecondsbetween(inicio,final));
          statusbar1.panels[12].text:='Binarizacion';
    end;


end;

procedure TForm1.Button3Click(Sender: TObject);
//histograma
var
  x : byte  ;
  i ,j,max,escala: integer;
begin
  //limpiamos y colocamos longitud

      image2.canvas.Pen.color := clwhite;
      image2.canvas.rectangle(0,0,image2.Width,image2.height);

      setLength(vector,256);
      //limpiamos el vector
      for i:= 0 to 255 do begin
          vector[i] := 0;
      end;
      //llenamos el vectoor
      for i:= 0 to alto-1 do begin
          for j:= 0 to ancho-1 do begin
          inc(vector[mat[i,j,0]]);
          end;
      end;
      //calculamos el maximo
      max := vector[0];
      for i :=1 to 255 do begin
          if(vector[i] > max) then begin
            max := vector[i];
          end;
      end;

      //dibujamos
      image2.Canvas.pen.color := clblack;
      //encontramos escala
      escala := round((image2.Height-1)*(1-vector[0]/max));
      image2.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image2.Height-1)*(1-vector[i]/max));
           image2.Canvas.LineTo(i,image2.height);
            image2.Canvas.LineTo(i,escala);

       end;

end;

procedure TForm1.Button4Click(Sender: TObject);
//falso color
var
  i,j,k : integer;
  cl1,cl2 : tcolor;
  r,v,a : integer;
begin
     image1.picture.savetofile('temp.bmp');
  form2.Caption:='Falso color';

  form2.ShowModal;

   if (form2.modalresult = mrok) then
     begin
          //obtenemos color y pintamos el rango del falso color
         cl1 :=form2.shape1.brush.color;
         cl2 :=form2.shape2.brush.color;
         Image3.Canvas.Pen.Color:=RGB(GetRvalue(cl1),GetGvalue(cl1),GetBvalue(cl1));
         image3.Canvas.Line(0,0,0,Image3.Height);
         Image3.Canvas.Pen.Color:=RGB(GetRvalue(cl2),GetGvalue(cl2),GetBvalue(cl2));
         image3.Canvas.Line(Image3.Width,0,Image3.Width,Image3.Height);

         for i:=1 to 255 do begin
             r := round(GetRvalue(cl1)+i*(GetRvalue(cl2)-GetRvalue(cl1))/255);
             v := round(GetGvalue(cl1)+i*(GetGvalue(cl2)-GetGvalue(cl1))/255);
             a := round(GetBvalue(cl1)+i*(GetBvalue(cl2)-GetBvalue(cl1))/255);
             Image3.Canvas.Pen.Color := RGB(r, v, a);
             Image3.Canvas.Line(i,0,i,Image3.Height);
         end;

         //operamos la matriz y mostramos el resultado
          for i := 0 to ALTO-1 do begin
             for j := 0 to ANCHO-1 do begin
                 MAT[i,j,0] := round(GetRvalue(cl1)+MAT[i,j,0]*(GetRvalue(cl2)-GetRvalue(cl1))/255);
                 MAT[i,j,1] := round(GetGvalue(cl1)+MAT[i,j,1]*(GetGvalue(cl2)-GetGvalue(cl1))/255);
                 MAT[i,j,2] := round(GetBvalue(cl1)+MAT[i,j,2]*(GetBvalue(cl2)-GetBvalue(cl1))/255);

                 end;
             end;

          //movemos matriz a canvas
           copiamat(alto,ancho);
           statusbar1.panels[12].text:='Falso color';

     end;
end;

procedure TForm1.Button5Click(Sender: TObject);
//restaurar matriz
var
  i,j,k : integer;
  cl: tcolor;
begin
    inicio:=now;
    for i:=0 to alto-1 do begin
        for j:=0 to ancho-1 do begin
              cl:=RGB(auxm[i,j,0],auxm[i,j,1],auxm[i,j,2]);
              image1.canvas.pixels[j,i]:= cl;
        end;
    end;
    final:=now;

    statusbar1.panels[10].text:=floattostr(millisecondsbetween(inicio,final));

end;

procedure TForm1.Button6Click(Sender: TObject);
//desplazamiento
var
  i,j,k,desp : integer;
begin
   image1.picture.savetofile('temp.bmp');
   desplazamiento(alto,ancho,vector);
end;

procedure TForm1.Button7Click(Sender: TObject);
//sobel
var
  i,j,k,a,b,sumatoria : integer;


begin
   image1.picture.savetofile('temp.bmp');
   sumatoria := 0;
  setlength(auxmconv,alto,ancho,3);
  for i:=1 to alto-2  do begin
      for j:=1 to ancho-2 do begin
          for k:=0 to 2 do begin
              for a:=-1 to 1 do begin
                         for b:=-1 to 1 do begin
                             sumatoria := sumatoria + mat[i+a,j+b,k] * masc[a+1,b+1];
                         end;
              end;
              auxmconv[i,j,k] := abs(sumatoria) div 4;
              sumatoria := 0;
          end;
      end;
  end;
  for i:=0 to alto-1 do begin
    for j:=0 to ancho -1 do begin
        for k:=0 to 2 do begin
            mat[i,j,k] := auxmconv[i,j,k];
        end;
    end;
  end;
 copiamat(alto,ancho);
end;

procedure TForm1.Button8Click(Sender: TObject);
//operaciones aritmeticas
var
i,j,k : Integer;
cl: tcolor;
begin
 image1.picture.savetofile('temp.bmp');
     form3.ShowModal;

     if (form3.modalresult = mrok) then  begin
          //abir el archivo y cargarlo a canvas
             Image1.enabled:=true;
    Image1.Picture.LoadFromFile('resultado.bmp');
    nomArch := 'resultado.bmp';
    image1.picture.savetofile('temp.bmp');

    alto:=Image1.Height;
    ancho:=Image1.Width;
    statusbar1.panels[8].text:=inttostr(alto) + 'x' + inttostr(ancho);


    //copiar contenido


     //matriz original
    setLength(mat,alto,ancho,3);
    //matriz grises
    setLength(mati,alto,ancho,3);
    //matriz de respaldo
    setLength(auxm,alto,ancho,3);

     copiacanv(alto,ancho,mat);


    //copiar contenido matriz original a aux
    for i:=0 to alto-1 do begin
            for j:=0 to ancho-1 do begin
                for k:=0 to 2 do begin
                    auxm[i,j,k]:= mat[i,j,k];
                end;
            end;
     end;


            copiamat(alto,ancho);
     end;
end;

procedure TForm1.Button9Click(Sender: TObject);
//zoom in 2x
    var
    i,j,k ,ix,jx,a,b: integer ;
    nal,nan : integer;
    mzoom: matrgb;

begin
  image1.picture.savetofile('temp.bmp');
     nal := 2*alto;
     nan := 2*ancho;
     image1.Height:=nal;
     image1.Width:=nan;

     setlength(mzoom,nal,nan,3);
     //2x
     b:=2 ;

     //prosesamos todo menos los bordes
     for i:=0 to alto-2 do begin
          for j:=0 to ancho-2 do begin
                 for k:=0 to 2 do begin

                        mzoom[i*b,j*b,k] := mat[i,j,k];
                        mzoom[(i*b)+1,j*b,k] := round((mat[i,j,k]+mat[i,j+1,k])/2);
                        mzoom[i*b,(j*b)+1,k] := round((mat[i,j,k]+mat[i+1,j,k])/2);
                        mzoom[(i*b)+1,(j*b)+1,k] := round((mat[i,j,k]+mat[i+1,j+1,k])/2);
                 end;//k
          end;//j
     end;

     //precesamos el ultimo renglon
     i := alto-2;
     ix := nal-2 ;
     for j:=0 to ancho-2 do begin
         for k:=0 to 2 do begin
                 mzoom[ix,j*b,k] := mat[i,j,k];
                 mzoom[ix,(j*b)+1,k] := mat[i,j,k];
                 mzoom[ix+1,j*b,k] := mat[i,j,k];
                 mzoom[ix+1,(j*b)+1,k] := mat[i,j,k];

         end;
     end;

        //asignamos las nuevas dimensiones y nuevos datos
     alto := nal;
     ancho := nan;
      setlength(mat,alto,ancho,3);
     image1.Picture.Bitmap.SetSize(nan,nal);
     for i:=0 to alto-1 do begin
               for j:=0 to ancho -1 do begin
                   for k:=0 to 2 do begin
                       mat[i,j,k] := mzoom[i,j,k];
                       end;
                   end;
                   end;
     copiamat(alto,ancho);
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  cl: Tcolor;  //variable para almacenar el color del pixel [X,Y] de la imagen
  R,G,B:  Byte;

begin
  // EditX.Text:=IntToStr(X); //coordenada X que proporciona el evento al pasar el mouse sobre el TImage
   //EditY.Text:=IntToStr(Y); //coordenada Y que proporciona el evento al pasar el mouse sobre el TImage

   StatusBar1.Panels[1].text:=IntToStr(X);
   StatusBar1.Panels[2].text:=IntToStr(Y);


   StatusBar1.Panels[4].text:=IntToStr(mat[y,x,0]);
   StatusBar1.Panels[5].text:=IntToStr(mat[y,x,1]);
   StatusBar1.Panels[6].text:=IntToStr(mat[y,x,2]);
   //apartir de datos copiados a matriz base:




   //Extraer componentes R,G,B  usando funciones de la biblioteca LCLintf
   cl:=Image1.Canvas.Pixels[X,Y];

   R:=GetRValue(cl);
   G:=GetGValue(cl);
   B:=GetBValue(cl);

   //visualizar en cajas de texto
   //EditR.Text:=IntToStr(R);
   //EditG.Text:=IntToStr(G);
   //EditB.Text:=IntToStr(B);

end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;



procedure TForm1.MenuItem10Click(Sender: TObject);
//girses promedio
begin
   image1.picture.savetofile('temp.bmp');
     grisesprom(alto,ancho,mat);
     copiamat(alto,ancho);
     statusbar1.panels[12].text:='Grises promedio';
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
//binarizacion negro y blanco
begin
     image1.picture.savetofile('temp.bmp');
  binarizacion(alto, ancho, mat);
  copiamat(alto,ancho);
  statusbar1.panels[12].text:='binarizacion';

end;

procedure TForm1.MenuItem12Click(Sender: TObject);
//gama
begin
          image1.picture.savetofile('temp.bmp');
          gama(alto,ancho,mat);
          inicio:=now;
          copiamat(alto,ancho);
          final:=now;



    statusbar1.panels[10].text:=floattostr(millisecondsbetween(inicio,final));
    statusbar1.panels[12].text:='correcion gama';
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
//guardar como

begin
  if (savedialog1.Execute) then begin

            image1.picture.savetofile(savedialog1.filename);

  end;
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
//guardar

begin
    image1.picture.savetofile(nomarch);
  end;

procedure TForm1.MenuItem15Click(Sender: TObject);
//convolucion
var
   i,j,k,a,b,sumatoria : integer;
   valor : integer;
   total : integer;
   xa, xb : integer;
begin
  image1.picture.savetofile('temp.bmp');
         total := 0;
         form4.TrackBar1.position := 3 ;
            for i:=0 to 2 do begin
                for j:=0 to 2 do begin
                    form4.stringgrid1.Cells[i,j] :='0';
                end;
            end;
         form4.ShowModal;

     if (form4.modalresult = mrok) then begin
         sumatoria := 0;
         valor := form4.TrackBar1.position;
         setlength(matrizconvolucion,valor,valor);
         setlength( auxmconv,alto,ancho,3);
          case valor of
          2:begin
              xa:=0;
              xb:=1;
              end;
          3: begin
              xa := 1 ;
              xb := 1;
             end;
          4:begin
              xa:=2;
              xb:=1;
              end;
          5:begin
              xa :=2;
              xb :=2;
              end;
          end;

         //obtenemos mascara del usuario y obtenemos la suma total de sus valores positivos
          for i:=0 to valor-1 do begin
                for j:=0 to valor-1 do begin
                    matrizConvolucion[i,j] := strtoint(form4.stringgrid1.Cells[i,j]);
                    if matrizConvolucion[i,j] > 0 then
                      total := total + matrizconvolucion[i,j];
                end;
            end;

          //aplicamos mascara a imagen

          for i:=1 to alto-2  do begin
           for j:=1 to ancho-2 do begin
               for k:=0 to 2 do begin
                   for a:=-xa to xa do begin
                         for b:=-xb to xb do begin
                             sumatoria := sumatoria + mat[i+a,j+b,k] * matrizconvolucion[a+1,b+1];
                         end;
                   end;
              auxmconv[i,j,k] := abs(sumatoria) div total;
              sumatoria := 0;
              end;
             end;
           end;
          //copiamos auxiliar a principal
           for i:=0 to alto-1 do begin
               for j:=0 to ancho -1 do begin
                   for k:=0 to 2 do begin
                       mat[i,j,k] := auxmconv[i,j,k];
                       end;
                   end;
                   end;
           copiamat(alto,ancho);
     end;

end;

procedure TForm1.MenuItem16Click(Sender: TObject);
//incluir ruido
var
   i,j,k,a,b : integer;
   radio,r,an , al, times: integer;
   densidad : real;
   coox, cooy : integer;
   ban : integer;
   x,y : integer;
begin
     image1.picture.savetofile('temp.bmp');
     //poner ruido sal y pimienta en la imagen1
     form5.ShowModal;

     if (form5.modalresult = mrok) then begin
           ban := 1;
             r := form5.TrackBar1.Position;
             radio := r div(2);
             x:= radio;
             y:= radio;
             densidad := form5.TrackBar2.Position;
             densidad := round(densidad * 500000);
             times:=round(densidad/(alto*ancho))  ;

             //llenamos imagen con el ruido
              randomize;

              for i:=0 to times do begin
                   coox :=random(alto-1)+1;
                   cooy :=random(ancho-1)+1;
                   if ban = 1 then begin
                        for a:=-x to x do begin
                            for b:=-y to y do begin
                                mat[coox+a,cooy+b,0] := 0;
                                mat[coox+a,cooy+b,1] := 0;
                                 mat[coox+a,cooy+b,2] := 0;
                          end;
                        end;
                     ban := 0;
                   end  //if
                   else  begin
                         for a:=-1 to 1 do begin
                             for b:=-1 to 1 do begin
                                  mat[coox+a,cooy+b,0] := 255;
                                  mat[coox+a,cooy+b,1] := 255;
                                  mat[coox+a,cooy+b,2] := 255;
                                  end;
                         end;
                   ban := 1;
                   end;//else

              end; //end times
           copiamat(alto,ancho);
       end;


     end;

procedure TForm1.MenuItem17Click(Sender: TObject);
//suavizado mediante mediana
var
  i,j,k,a,b,pos: Integer;
  vectormediana: Array[0..8] of Integer;
  AUX: MATRGB;
begin
     image1.picture.savetofile('temp.bmp');
     setlength(AUX,ALTO,ANCHO,3);
  for i := 1 to ALTO-2 do begin
    for j := 1 to ANCHO-2 do begin
      for k := 0 to 2 do begin
        //Obtenemos los valores
        pos := 0;
        for a := -1 to 1 do begin
          for b := -1 to 1 do begin
            vectormediana[pos] := MAT[i+a,b+j,k];
            inc(pos);
          end; //b
        end; //a
        //Ordenamos los valores
        Burbuja(vectormediana);
        //Asignamos al pivote
        AUX[i,j,k] := vectormediana[4];
      end; //k
    end; //j
  end; //i
   for i:=0 to alto-1 do begin
               for j:=0 to ancho -1 do begin
                   for k:=0 to 2 do begin
                       mat[i,j,k] := aux[i,j,k];
                       end;
               end;
   end;
  copiamat(alto,ancho);

end;

procedure TForm1.MenuItem18Click(Sender: TObject);
//bordes de primer grado
var
  i,j,k : integer;
  x, y : byte;
begin
     setlength(auxmconv,alto,ancho,3);
     for i := 1 to alto-1 do begin
         for j := 1 to ancho -1 do begin
             for k:= 0 to 2 do begin
                  x := mat[i,j,k] - mat[i-1,j,k];
                  y := mat[i,j,k] - mat[i,j-1,k];
                  auxmconv[i,j,k] := round((abs(x)+abs(y))/2);

             end;
         end;
     end;
     for i:=0 to alto-1 do begin
    for j:=0 to ancho -1 do begin
        for k:=0 to 2 do begin
            mat[i,j,k] := auxmconv[i,j,k];
        end;
    end;
  end;
     copiamat(alto,ancho);
end;

procedure TForm1.MenuItem19Click(Sender: TObject);
//deshacer
begin
  Image1.Picture.LoadFromFile('temp.bmp');
  copiacanv(alto,ancho,mat);
end;






end.
