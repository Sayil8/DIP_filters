unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Buttons, ExtCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ColorDialog1: TColorDialog;
    Shape1: TShape;
    Shape2: TShape;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    TrackBar1: TTrackBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Shape1ChangeBounds(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2ChangeBounds(Sender: TObject);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackBar1Change(Sender: TObject);


  private
    { private declarations }
  public
    valor : integer;
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }





procedure TForm2.TrackBar1Change(Sender: TObject);
begin
       //label1.Caption:=inttostr(trackbar1.position);
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  valor:=trackbar1.position;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.Shape1ChangeBounds(Sender: TObject);
begin

end;

procedure TForm2.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     if shift=[ssleft] then begin

        colordialog1.Execute();
        shape1.Brush.Color:=colordialog1.Color;
     end;

end;

procedure TForm2.Shape2ChangeBounds(Sender: TObject);
begin

end;

procedure TForm2.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
       if shift=[ssleft] then begin

        colordialog1.Execute();
        shape2.Brush.Color:=colordialog1.Color;

     end;
end;

end.

