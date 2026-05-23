object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo de cadastro de produtos'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 622
    ExplicitHeight = 433
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 622
      Height = 439
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 620
      ExplicitHeight = 431
      object TabSheet1: TTabSheet
        Caption = 'Geral'
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 614
          Height = 41
          Align = alTop
          TabOrder = 0
          ExplicitWidth = 612
          object Label1: TLabel
            Left = 16
            Top = 16
            Width = 46
            Height = 15
            Caption = 'Pesquisa'
          end
          object Edit1: TEdit
            Left = 80
            Top = 8
            Width = 409
            Height = 23
            TabOrder = 0
          end
          object BitBtn1: TBitBtn
            Left = 504
            Top = 8
            Width = 75
            Height = 25
            Caption = 'Pesquisar'
            TabOrder = 1
          end
        end
        object DBGrid1: TDBGrid
          Left = 0
          Top = 41
          Width = 614
          Height = 368
          Align = alClient
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Manuten'#231#227'o'
        ImageIndex = 1
        object Label2: TLabel
          Left = 16
          Top = 24
          Width = 11
          Height = 15
          Caption = 'ID'
        end
        object Label3: TLabel
          Left = 16
          Top = 53
          Width = 68
          Height = 15
          Caption = 'Part Number'
        end
        object Label4: TLabel
          Left = 16
          Top = 82
          Width = 51
          Height = 15
          Caption = 'Descri'#231#227'o'
        end
        object Edit2: TEdit
          Left = 96
          Top = 21
          Width = 121
          Height = 23
          TabOrder = 0
        end
        object Edit3: TEdit
          Left = 96
          Top = 50
          Width = 121
          Height = 23
          TabOrder = 1
        end
        object Edit4: TEdit
          Left = 96
          Top = 79
          Width = 481
          Height = 23
          TabOrder = 2
        end
        object CheckBox1: TCheckBox
          Left = 520
          Top = 24
          Width = 57
          Height = 17
          Caption = 'Ativo'
          TabOrder = 3
        end
        object Panel3: TPanel
          Left = 0
          Top = 368
          Width = 614
          Height = 41
          Align = alBottom
          TabOrder = 4
          object BitBtn2: TBitBtn
            Left = 448
            Top = 8
            Width = 75
            Height = 25
            Kind = bkOK
            NumGlyphs = 2
            TabOrder = 0
          end
          object BitBtn3: TBitBtn
            Left = 529
            Top = 8
            Width = 75
            Height = 25
            Caption = 'Cancela'
            Kind = bkCancel
            NumGlyphs = 2
            TabOrder = 1
          end
        end
      end
    end
  end
end
