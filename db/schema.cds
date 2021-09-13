namespace sap.sfextension.refapp;

using {cuid} from '@sap/cds/common';


entity Project : cuid {
  projectName : String(25);         
  description : String(50);     
  criticality : String(1) default 'O'@mandatory;
  status      : Association to Status
                  on status.id = criticality;
  employees   : Composition of many EmployeeProjectMapping
                  on employees.project = $self;
}


entity EmployeeProjectMapping : cuid {
  employeeId : String(6) not null @assert.mandatory: false;
  project    : Association to Project;
  identifierFieldControl : TechnicalFieldControlFlag not null default 7;
}

type TechnicalFieldControlFlag : Integer @(
    UI.Hidden,
    Core.Computed
);
entity Notifications : cuid {
  message    : String(20);
  employeeId : String;
  managerId  : String;
  readStatus : Boolean;
  @cds.persistence.skip
  @UI.MultiLineText
  skills     : String(300);
  createdAt  : DateTime @cds.on.insert : $now;
  empn       : Association to many EmployeeProjectMapping
                 on empn.employeeId = employeeId;
}


entity Status {
  key id         : String    @(
        Common.Text            : StatusI,
        Common.TextArrangement : #TextOnly,
        Common.Label           : '{i18n>statusid}',
        Common.FieldControl    : #ReadOnly
      );
      StatusI    : String(20)@(
        Common.Label        : '{i18n>projectstatus}',
        Common.FieldControl : #ReadOnly
      );
      crticality : Integer   @(Common.FieldControl : #ReadOnly);
      editable   : Integer
}
