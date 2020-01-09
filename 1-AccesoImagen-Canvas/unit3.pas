unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ExtDlgs,LCLintf,math;

type

  { TForm3 }

  matrgb= Array of Array of Array of byte;
  histro = array of byte;

  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    OpenPictureDialog2: TOpenPictureDialog;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    ScrollBox3: TScrollBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Label2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);

    procedure Label2EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure Label3DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Label3DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Label3EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure Label4DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Label4DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Label4EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure Label6DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Label6DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Label6EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure Label7DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Label7DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Label7EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure Label8DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Label8DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Label8EndDrag(Sender, Target: TObject; X, Y: Integer);



  private
    { private declarations }
  public
    { public declarations }
    procedure copiacanv(al, an: Integer; var m: matrgb); //matriz a canv
    procedure copiacanv(al,an:Integer; var m:matrgb; img: timage);
    procedure copiacanv2(al,an:Integer; var m:matrgb);
    procedure copiamat(al,an: Integer);

  end;

var
  Form3: TForm3;
  alto, ancho,alto2,ancho2,alto3,ancho3: integer;
  mat1,mat2,mat3,matI1,matI2,matI3 :matrgb; //mat[cx,cy,canal]
  vector,vector2,vector3 : histro;

implementation

{$R *.lfm}

{ TForm3 }

procedure tform3.copiacanv(al,an:Integer; var m:matrgb);

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
procedure tform3.copiacanv(al,an:Integer; var m:matrgb; img:timage);

var

  i,j : Integer;
  cl: tcolor;

  begin
    for i:=0 to al-1 do begin
        for j:=0 to an-1 do begin
            cl:=img.Canvas.Pixels[j,i];
            m[i,j,0]:=GetRValue(cl);
            m[i,j,1]:=GetGValue(cl);
            m[i,j,2]:=GetBValue(cl);
        end;
    end;
  end;
procedure tform3.copiacanv2(al,an:Integer; var m:matrgb);

var

  i,j : Integer;
  cl: tcolor;

  begin
    for i:=0 to al-1 do begin
        for j:=0 to an-1 do begin
            cl:=Image2.Canvas.Pixels[j,i];
            m[i,j,0]:=GetRValue(cl);
            m[i,j,1]:=GetGValue(cl);
            m[i,j,2]:=GetBValue(cl);
        end;
    end;
  end;
procedure tform3.copiamat(al,an: Integer);

var
  i,j: Integer;
  cl: tcolor;

  begin
    for i:=0 to al-1 do begin
        for j:=0 to an-1 do begin
              cl:=RGB(Mat3[i,j,0],Mat3[i,j,1],Mat3[i,j,2]);

              image3.canvas.pixels[j,i]:= cl;
        end;
    end;
  end;
procedure TForm3.Image1Click(Sender: TObject);
begin

end;

procedure TForm3.Label2Click(Sender: TObject);
begin

end;

procedure TForm3.Label2DragDrop(Sender, Source: TObject; X, Y: Integer);
var
i,j,k,max,escala : integer;
img : timage;
begin
        Image3.enabled:=true;
        image6.Enabled:=true;

        //declaramos tamaño de la imagen nueva
        if(alto > alto2) then begin
              alto3:= alto2;
        end
        else
              alto3:= alto;
         if(ancho > ancho2) then begin
              ancho3:= ancho2;
        end
        else
              ancho3:= ancho;
    //matriz original
    setLength(mat3,alto3,ancho3,3);
    //matriz intensidad
    setLength(matI3,alto3,ancho3,3);

     Image3.enabled:=true;
     image3.Height:=alto3;
     image3.Width:=ancho3;

        //sumamos las dos imagenes


       for i:=0 to alto3 -1 do begin
           for j:=0 to ancho3 -1 do begin
               for k:=0 to 2 do begin
                   mat3[i,j,k] := mat1[i,j,k] + mat2[i,j,k];
                   if (mat3[i,j,k]>255) then
                      mat3[i,j,k] := 255;
                   end;
               end;
           end;
     img:= image3;
     copiamat(alto3,ancho3);

    //dibujamos el histrograma

    image6.canvas.Pen.color := clwhite;
    image6.canvas.rectangle(0,0,image6.Width,image6.height);

      setLength(vector3,256);
      //limpiamos el vector
      for i:= 0 to 255 do begin
          vector3[i] := 0;
      end;

       //Calculamos matriz de intensidad

       for i:=0 to alto3-1 do begin
            for j:=0 to ancho3-1 do begin
                for k:=0 to 2 do begin
                    matI3[i,j,k]:= mat3[i,j,k];
                end;
            end;
     end;
     //matriz a gris
     for i:=0 to alto3-1 do begin
         for j:=0 to ancho3-1 do begin
               matI3[i,j,0]:=matI3[i,j,2];
               matI3[i,j,1]:=matI3[i,j,2];


         end;
     end;


         image6.Canvas.pen.color := clblack;
         for i:= 0 to alto3-1 do begin
          for j:= 0 to ancho3-1 do begin
              inc(vector3[matI3[i,j,0]]);
          end;
         end;

      //calculamos el maximo
      max := vector3[0];
      for i :=1 to 255 do begin
          if(vector3[i] > max) then begin
            max := vector3[i];
          end;
      end;

      //dibujamos

      //encontramos escala
      escala := round((image6.Height-1)*(1-vector3[0]/max));
      image6.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image6.Height-1)*(1-vector3[i]/max));
           image6.Canvas.LineTo(i,image6.height);
           image6.Canvas.LineTo(i,escala);

       end;

end;

procedure TForm3.Label2DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin

end;


procedure TForm3.Label2EndDrag(Sender, Target: TObject; X, Y: Integer);
begin

end;

procedure TForm3.Label3DragDrop(Sender, Source: TObject; X, Y: Integer);
var
  i,j,k,max,escala : integer;
begin
       //multiplicacion
       Image3.enabled:=true;
       image6.Enabled:=true;
        //declaramos tamaño de la imagen nueva
        if(alto > alto2) then begin
              alto3:= alto2;
        end
        else
              alto3:= alto;
         if(ancho > ancho2) then begin
              ancho3:= ancho2;
        end
        else
              ancho3:= ancho;
    //matriz original
    setLength(mat3,alto3,ancho3,3);
    //matriz intensidad
    setLength(matI3,alto3,ancho3,3);

     Image3.enabled:=true;
     image3.Height:=alto3;
     image3.Width:=ancho3;

      //multiplicamos las imagenes
         for i:=0 to alto3 -1 do begin
           for j:=0 to ancho3 -1 do begin
               for k:=0 to 2 do begin
                   mat3[i,j,k] := (mat1[i,j,k] * mat2[i,j,k]) div (255);

                   end;
               end;
           end;

     copiamat(alto3,ancho3);

    //dibujamos el histrograma

    image6.canvas.Pen.color := clwhite;
    image6.canvas.rectangle(0,0,image6.Width,image6.height);

      setLength(vector3,256);
      //limpiamos el vector
      for i:= 0 to 255 do begin
          vector3[i] := 0;
      end;

       //Calculamos matriz de intensidad

       for i:=0 to alto3-1 do begin
            for j:=0 to ancho3-1 do begin
                for k:=0 to 2 do begin
                    matI3[i,j,k]:= mat3[i,j,k];
                end;
            end;
     end;
     //matriz a gris
     for i:=0 to alto3-1 do begin
         for j:=0 to ancho3-1 do begin
               matI3[i,j,0]:=matI3[i,j,2];
               matI3[i,j,1]:=matI3[i,j,2];


         end;
     end;


         image6.Canvas.pen.color := clblack;
         for i:= 0 to alto3-1 do begin
          for j:= 0 to ancho3-1 do begin
              inc(vector3[matI3[i,j,0]]);
          end;
         end;

      //calculamos el maximo
      max := vector3[0];
      for i :=1 to 255 do begin
          if(vector3[i] > max) then begin
            max := vector3[i];
          end;
      end;

      //dibujamos

      //encontramos escala
      escala := round((image6.Height-1)*(1-vector3[0]/max));
      image6.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image6.Height-1)*(1-vector3[i]/max));
           image6.Canvas.LineTo(i,image6.height);
           image6.Canvas.LineTo(i,escala);

       end;

end;

procedure TForm3.Label3DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin

end;

procedure TForm3.Label3EndDrag(Sender, Target: TObject; X, Y: Integer);
begin

end;

procedure TForm3.Label4DragDrop(Sender, Source: TObject; X, Y: Integer);
var
i,j,k,max,escala : integer;
begin
      //resta
       Image3.enabled:=true;
       image6.Enabled:=true;

        //declaramos tamaño de la imagen nueva
        if(alto > alto2) then begin
              alto3:= alto2;
        end
        else
              alto3:= alto;
         if(ancho > ancho2) then begin
              ancho3:= ancho2;
        end
        else
              ancho3:= ancho;
    //matriz original
    setLength(mat3,alto3,ancho3,3);
    //matriz intensidad
    setLength(matI3,alto3,ancho3,3);

     Image3.enabled:=true;
     image3.Height:=alto3;
     image3.Width:=ancho3;

      //restamos las dos imagenes


       for i:=0 to alto3 -1 do begin
           for j:=0 to ancho3 -1 do begin
               for k:=0 to 2 do begin
                   mat3[i,j,k] := mat1[i,j,k] - mat2[i,j,k];
                   if (mat3[i,j,k]<0) then
                      mat3[i,j,k] := 0;
                   end;
               end;
           end;

     copiamat(alto3,ancho3);

    //dibujamos el histrograma

    image6.canvas.Pen.color := clwhite;
    image6.canvas.rectangle(0,0,image6.Width,image6.height);

      setLength(vector3,256);
      //limpiamos el vector
      for i:= 0 to 255 do begin
          vector3[i] := 0;
      end;

       //Calculamos matriz de intensidad

       for i:=0 to alto3-1 do begin
            for j:=0 to ancho3-1 do begin
                for k:=0 to 2 do begin
                    matI3[i,j,k]:= mat3[i,j,k];
                end;
            end;
     end;
     //matriz a gris
     for i:=0 to alto3-1 do begin
         for j:=0 to ancho3-1 do begin
               matI3[i,j,0]:=matI3[i,j,2];
               matI3[i,j,1]:=matI3[i,j,2];


         end;
     end;


         image6.Canvas.pen.color := clblack;
         for i:= 0 to alto3-1 do begin
          for j:= 0 to ancho3-1 do begin
              inc(vector3[matI3[i,j,0]]);
          end;
         end;

      //calculamos el maximo
      max := vector3[0];
      for i :=1 to 255 do begin
          if(vector3[i] > max) then begin
            max := vector3[i];
          end;
      end;

      //dibujamos

      //encontramos escala
      escala := round((image6.Height-1)*(1-vector3[0]/max));
      image6.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image6.Height-1)*(1-vector3[i]/max));
           image6.Canvas.LineTo(i,image6.height);
           image6.Canvas.LineTo(i,escala);

       end;

end;

procedure TForm3.Label4DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin

end;

procedure TForm3.Label4EndDrag(Sender, Target: TObject; X, Y: Integer);
begin

end;

procedure TForm3.Label6DragDrop(Sender, Source: TObject; X, Y: Integer);
var
i,j,k,max,escala : integer;
begin
       //AND
       Image3.enabled:=true;
       image6.Enabled:=true;

        //declaramos tamaño de la imagen nueva
        if(alto > alto2) then begin
              alto3:= alto2;
        end
        else
              alto3:= alto;
         if(ancho > ancho2) then begin
              ancho3:= ancho2;
        end
        else
              ancho3:= ancho;
    //matriz original
    setLength(mat3,alto3,ancho3,3);
    //matriz intensidad
    setLength(matI3,alto3,ancho3,3);

     Image3.enabled:=true;
     image3.Height:=alto3;
     image3.Width:=ancho3;

      //restamos las dos imagenes


       for i:=0 to alto3 -1 do begin
           for j:=0 to ancho3 -1 do begin
               for k:=0 to 2 do begin
                   mat3[i,j,k] := mat1[i,j,k] and mat2[i,j,k];
                   end;
               end;
           end;

     copiamat(alto3,ancho3);

    //dibujamos el histrograma

    image6.canvas.Pen.color := clwhite;
    image6.canvas.rectangle(0,0,image6.Width,image6.height);

      setLength(vector3,256);
      //limpiamos el vector
      for i := 0 to 255 do begin
          vector3[i] := 0;
      end;

       //Calculamos matriz de intensidad

       for i:=0 to alto3-1 do begin
            for j:=0 to ancho3-1 do begin
                for k:=0 to 2 do begin
                    matI3[i,j,k]:= mat3[i,j,k];
                end;
            end;
     end;
     //matriz a gris
     for i:=0 to alto3-1 do begin
         for j:=0 to ancho3-1 do begin
               matI3[i,j,0]:=matI3[i,j,2];
               matI3[i,j,1]:=matI3[i,j,2];


         end;
     end;


         image6.Canvas.pen.color := clblack;
         for i:= 0 to alto3-1 do begin
          for j:= 0 to ancho3-1 do begin
              inc(vector3[matI3[i,j,0]]);
          end;
         end;

      //calculamos el maximo
      max := vector3[0];
      for i :=1 to 255 do begin
          if(vector3[i] > max) then begin
            max := vector3[i];
          end;
      end;

      //dibujamos

      //encontramos escala
      escala := round((image6.Height-1)*(1-vector3[0]/max));
      image6.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image6.Height-1)*(1-vector3[i]/max));
           image6.Canvas.LineTo(i,image6.height);
           image6.Canvas.LineTo(i,escala);

       end;
end;

procedure TForm3.Label6DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin

end;

procedure TForm3.Label6EndDrag(Sender, Target: TObject; X, Y: Integer);
begin

end;

procedure TForm3.Label7DragDrop(Sender, Source: TObject; X, Y: Integer);
var
   i,j,k,max,escala : integer;
begin
    //xor
       Image3.enabled:=true;
       image6.Enabled:=true;

        //declaramos tamaño de la imagen nueva
        if(alto > alto2) then begin
              alto3:= alto2;
        end
        else
              alto3:= alto;
         if(ancho > ancho2) then begin
              ancho3:= ancho2;
        end
        else
              ancho3:= ancho;
    //matriz original
    setLength(mat3,alto3,ancho3,3);
    //matriz intensidad
    setLength(matI3,alto3,ancho3,3);

     Image3.enabled:=true;
     image3.Height:=alto3;
     image3.Width:=ancho3;

      //restamos las dos imagenes


       for i:=0 to alto3 -1 do begin
           for j:=0 to ancho3 -1 do begin
               for k:=0 to 2 do begin
                   mat3[i,j,k] := mat1[i,j,k] xor mat2[i,j,k];
                   end;
               end;
           end;

     copiamat(alto3,ancho3);

    //dibujamos el histrograma

    image6.canvas.Pen.color := clwhite;
    image6.canvas.rectangle(0,0,image6.Width,image6.height);

      setLength(vector3,256);
      //limpiamos el vector
      for i := 0 to 255 do begin
          vector3[i] := 0;
      end;

       //Calculamos matriz de intensidad

       for i:=0 to alto3-1 do begin
            for j:=0 to ancho3-1 do begin
                for k:=0 to 2 do begin
                    matI3[i,j,k]:= mat3[i,j,k];
                end;
            end;
     end;
     //matriz a gris
     for i:=0 to alto3-1 do begin
         for j:=0 to ancho3-1 do begin
               matI3[i,j,0]:=matI3[i,j,2];
               matI3[i,j,1]:=matI3[i,j,2];


         end;
     end;


         image6.Canvas.pen.color := clblack;
         for i:= 0 to alto3-1 do begin
          for j:= 0 to ancho3-1 do begin
              inc(vector3[matI3[i,j,0]]);
          end;
         end;

      //calculamos el maximo
      max := vector3[0];
      for i :=1 to 255 do begin
          if(vector3[i] > max) then begin
            max := vector3[i];
          end;
      end;

      //dibujamos

      //encontramos escala
      escala := round((image6.Height-1)*(1-vector3[0]/max));
      image6.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image6.Height-1)*(1-vector3[i]/max));
           image6.Canvas.LineTo(i,image6.height);
           image6.Canvas.LineTo(i,escala);

       end;
end;

procedure TForm3.Label7DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin

end;

procedure TForm3.Label7EndDrag(Sender, Target: TObject; X, Y: Integer);
begin

end;

procedure TForm3.Label8DragDrop(Sender, Source: TObject; X, Y: Integer);
var
   i,j,k,max,escala : integer;
begin
      //or
       Image3.enabled:=true;
       image6.Enabled:=true;

        //declaramos tamaño de la imagen nueva
        if(alto > alto2) then begin
              alto3:= alto2;
        end
        else
              alto3:= alto;
         if(ancho > ancho2) then begin
              ancho3:= ancho2;
        end
        else
              ancho3:= ancho;
    //matriz original
    setLength(mat3,alto3,ancho3,3);
    //matriz intensidad
    setLength(matI3,alto3,ancho3,3);

     Image3.enabled:=true;
     image3.Height:=alto3;
     image3.Width:=ancho3;

      //restamos las dos imagenes


       for i:=0 to alto3 -1 do begin
           for j:=0 to ancho3 -1 do begin
               for k:=0 to 2 do begin
                   mat3[i,j,k] := mat1[i,j,k] or mat2[i,j,k];
                   end;
               end;
           end;

     copiamat(alto3,ancho3);

    //dibujamos el histrograma

    image6.canvas.Pen.color := clwhite;
    image6.canvas.rectangle(0,0,image6.Width,image6.height);

      setLength(vector3,256);
      //limpiamos el vector
      for i := 0 to 255 do begin
          vector3[i] := 0;
      end;

       //Calculamos matriz de intensidad

       for i:=0 to alto3-1 do begin
            for j:=0 to ancho3-1 do begin
                for k:=0 to 2 do begin
                    matI3[i,j,k]:= mat3[i,j,k];
                end;
            end;
     end;
     //matriz a gris
     for i:=0 to alto3-1 do begin
         for j:=0 to ancho3-1 do begin
               matI3[i,j,0]:=matI3[i,j,2];
               matI3[i,j,1]:=matI3[i,j,2];


         end;
     end;


         image6.Canvas.pen.color := clblack;
         for i:= 0 to alto3-1 do begin
          for j:= 0 to ancho3-1 do begin
              inc(vector3[matI3[i,j,0]]);
          end;
         end;

      //calculamos el maximo
      max := vector3[0];
      for i :=1 to 255 do begin
          if(vector3[i] > max) then begin
            max := vector3[i];
          end;
      end;

      //dibujamos

      //encontramos escala
      escala := round((image6.Height-1)*(1-vector3[0]/max));
      image6.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image6.Height-1)*(1-vector3[i]/max));
           image6.Canvas.LineTo(i,image6.height);
           image6.Canvas.LineTo(i,escala);

       end;
end;

procedure TForm3.Label8DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin

end;

procedure TForm3.Label8EndDrag(Sender, Target: TObject; X, Y: Integer);
begin

end;


procedure TForm3.Button1Click(Sender: TObject);
var
  i,j,k,max,escala : integer;
begin
  If OpenPictureDialog1.Execute  then  begin
  Image1.enabled:=true;
  Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);

  alto:=Image1.Height;
  ancho:=Image1.Width;


  //matriz original
    setLength(mat1,alto,ancho,3);
    //matriz intensidad
    setLength(matI1,alto,ancho,3);

    copiacanv(alto,ancho,mat1);

    //dibujamos histrograma
     image4.canvas.Pen.color := clwhite;
     image4.canvas.rectangle(0,0,image4.Width,image4.height);

      setLength(vector,256);
      //limpiamos el vector
      for i:= 0 to 255 do begin
          vector[i] := 0;
      end;

       //Calculamos matriz de intensidad

       for i:=0 to alto-1 do begin
            for j:=0 to ancho-1 do begin
                for k:=0 to 2 do begin
                    matI1[i,j,k]:= mat1[i,j,k];
                end;
            end;
     end;

     for i:=0 to alto-1 do begin
         for j:=0 to ancho-1 do begin
               matI1[i,j,0]:=matI1[i,j,2];
               matI1[i,j,1]:=matI1[i,j,2];


         end;
     end;


         image4.Canvas.pen.color := clblack;
         for i:= 0 to alto-1 do begin
          for j:= 0 to ancho-1 do begin
              inc(vector[matI1[i,j,0]]);
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

      //encontramos escala
      escala := round((image4.Height-1)*(1-vector[0]/max));
      image4.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image4.Height-1)*(1-vector[i]/max));
           image4.Canvas.LineTo(i,image4.height);
           image4.Canvas.LineTo(i,escala);

       end;

    end;
  end;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
  image3.picture.savetofile('resultado.bmp');
end;

procedure TForm3.Button2Click(Sender: TObject);
var
   i,j,k,max,escala : integer;
begin
     If OpenPictureDialog2.Execute  then  begin
  Image2.enabled:=true;
  Image2.Picture.LoadFromFile(OpenPictureDialog2.FileName);

  alto2:=Image2.Height;
  ancho2:=Image2.Width;


  //matriz original
    setLength(mat2,alto2,ancho2,3);
    //matriz intensidad
    setLength(matI2,alto2,ancho2,3);

    copiacanv2(alto2,ancho2,mat2);

    //dibujamos histrograma
     image5.canvas.Pen.color := clwhite;
     image5.canvas.rectangle(0,0,image5.Width,image5.height);

      setLength(vector2,256);
      //limpiamos el vector
      for i:= 0 to 255 do begin
          vector2[i] := 0;
      end;

       //Calculamos matriz de intensidad

       for i:=0 to alto2-1 do begin
            for j:=0 to ancho2-1 do begin
                for k:=0 to 2 do begin
                    matI2[i,j,k]:= mat2[i,j,k];
                end;
            end;
     end;

     for i:=0 to alto2-1 do begin
         for j:=0 to ancho2-1 do begin
               matI2[i,j,0]:=matI2[i,j,2];
               matI2[i,j,1]:=matI2[i,j,2];


         end;
     end;


         image5.Canvas.pen.color := clblack;
         for i:= 0 to alto2-1 do begin
          for j:= 0 to ancho2-1 do begin
              inc(vector2[matI2[i,j,0]]);
          end;
         end;

      //calculamos el maximo
      max := vector2[0];
      for i :=1 to 255 do begin
          if(vector2[i] > max) then begin
            max := vector2[i];
          end;
      end;

      //dibujamos

      //encontramos escala
      escala := round((image5.Height-1)*(1-vector2[0]/max));
      image5.Canvas.MoveTo(0,escala);
       for i :=1 to 255 do begin
           escala := round((image5.Height-1)*(1-vector2[i]/max));
           image5.Canvas.LineTo(i,image5.height);
           image5.Canvas.LineTo(i,escala);

       end;

    end;
  end;

end.
