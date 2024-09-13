create sequence BATCH_JOB_EXECUTION_SEQ
    minvalue 0
    maxvalue 9223372036854775807;

create sequence BATCH_JOB_SEQ
    minvalue 0
    maxvalue 9223372036854775807;

create sequence BATCH_STEP_EXECUTION_SEQ
    minvalue 0
    maxvalue 9223372036854775807;

create sequence SEQ_ACCOUNTCLOSE;

create sequence SEQ_ACCOUNTOPEN;

create sequence SEQ_ACCOUNTOPENFILE;

create sequence SEQ_ACCOUNTREPORTFILE;

create sequence SEQ_ACCOUNTSTATEMENTFILE;

create sequence SEQ_ACCOUNTSTATEMENTLINE
    order;

create sequence SEQ_ACCOUNTTRANSFER;

create sequence SEQ_ACTIVESAVINGSDOCUMENT;

create sequence SEQ_ALERT;

create sequence SEQ_ALERTACTION;

create sequence SEQ_ALERTAREA;

create sequence SEQ_ALERTHREF;

create sequence SEQ_ALERTKEYVALUE;

create sequence SEQ_ALERTSOURCE;

create sequence SEQ_ALERT_EVENT;

create sequence SEQ_AO2ARF;

create sequence SEQ_APPCONFIGURATION;

create sequence SEQ_AUDITACTION;

create sequence SEQ_AUDITTRANSACTION;

create sequence SEQ_BACSCONFIGURATION;

create sequence SEQ_BANKACCOUNT;

create sequence SEQ_BANKADDRESS;

create sequence SEQ_BANKHOLIDAY;

create sequence SEQ_BANKMESSAGINGPROFILE;

create sequence SEQ_BANKSYNCHRONIZATIONPROCESS;

create sequence SEQ_BLOCKID
    order;

create sequence SEQ_CARDPAYMENT;

create sequence SEQ_CASHACCOUNT;

create sequence SEQ_CASHACCOUNTBALANCE;

create sequence SEQ_CASHACCOUNTOPENING;

create sequence SEQ_CASHACCOUNTTYPE;

create sequence SEQ_CASHMOVEMENT
    order;

create sequence SEQ_CIFASREPORT;

create sequence SEQ_CLEARERBANK;

create sequence SEQ_CLEARINGCALENDAREXCEPTION;

create sequence SEQ_CLIENTSTATEMENT;

create sequence SEQ_CRONSCHEDULE;

create sequence SEQ_CUSTOMER;

create sequence SEQ_CUSTOMER2FEATURE;

create sequence SEQ_FEATURE;

create sequence SEQ_FEATURETOGGLE;

create sequence SEQ_FILEUPLOAD;

create sequence SEQ_FUNDINGORDER
    order;

create sequence SEQ_GENERICORDER
    order;

create sequence SEQ_HLAMBANK;

create sequence SEQ_HLPRODUCTLIMIT;

create sequence SEQ_IAMSETTINGS;

create sequence SEQ_INSTRUCTIONORDER;

create sequence SEQ_INSTRUMENT;

create sequence SEQ_INSTRUMENTDETAIL
    order;

create sequence SEQ_INSTRUMENTTEMPLATE;

create sequence SEQ_INTERESTORDER
    order;

create sequence SEQ_INTERNALUSER;

create sequence SEQ_ISATRANSFERORDER;

create sequence SEQ_JMSMESSAGE
    order;

create sequence SEQ_JOURNAL;

create sequence SEQ_JOURNALENTRY;

create sequence SEQ_JOURNALGROUP;

create sequence SEQ_MT101_SENDERS_REFERENCE;

create sequence SEQ_MT940SCHEDULE
    nocache;

create sequence SEQ_ORDERREFERENCE;

create sequence SEQ_PARTNERBANK;

create sequence SEQ_PARTNERBANKDETAILS
    order;

create sequence SEQ_PARTNERBANKFEESINVOICE
    order;

create sequence SEQ_PARTNERBANKPERMISSION
    order;

create sequence SEQ_PARTNERBANKSYNCMODEL;

create sequence SEQ_PAYMENT;

create sequence SEQ_PAYMENTFILE;

create sequence SEQ_PAYMENTHISTORY;

create sequence SEQ_PAYMENTSTATUSFILE;

create sequence SEQ_PAYMENTSTATUSREASONINFO;

create sequence SEQ_PBFEES;

create sequence SEQ_PERMISSION;

create sequence SEQ_PRINCIPALORDER
    order;

create sequence SEQ_PRODUCT;

create sequence SEQ_PRODUCTFEE;

create sequence SEQ_REPORTFILE;

create sequence SEQ_ROLE;

create sequence SEQ_SECURITYQUESTION;

create sequence SEQ_SLATIMES;

create sequence SEQ_SUBSCRIPTION;

create sequence SEQ_SWEEPERCLEARING
    order;

create sequence SEQ_SWEEPERPROCESS
    order;

create sequence SEQ_SWIFTMESSAGEREFERENCE;

create sequence SEQ_SWIFTPROCESSIDREFERENCE;

create sequence SEQ_SYNCHRONIZATIONPROCESS;

create sequence SEQ_TAG86FIELD;

create sequence SEQ_TRANSACTIONREFERENCE;

create sequence SEQ_TRANSFERORDER;

create sequence SEQ_TREASURYBLOCK;

create sequence SEQ_TREASURYBLOCKBALANCE;

create sequence SEQ_TREASURYBLOCKINTEREST;

create sequence SEQ_TREASURYBLOCKSTATEMENT;

create sequence SEQ_TREASURYOPERATION;

create sequence SEQ_USERPASSWORD;

create sequence SEQ_USERSECURITYANSWER;

create sequence SEQ_HLPRODUCT;

create sequence SEQ_WITHDRAWALNOTE;

create sequence SEQ_WITHDRAWALORDER;

create sequence SEQ_WITHDRAWALORDER2PAYMENT;

create sequence SEQ_WITHDRAWALORDERHISTORY;

create sequence SEQ_ORDERFORM;

create sequence SEQ_ISAORDERFORMDETAIL;

create sequence SEQ_PENALTYORDER;

create sequence SEQ_ASAORDERFORMDETAIL;

create sequence SEQ_PAYBYBANKORDERFORMDETAIL;

create sequence SEQ_PAYBYBANKORDER;

create sequence SEQ_RESTMESSAGE;

create table ACCOUNTOPENFILE
(
    ACCOUNTOPENFILEID NUMBER            not null
        constraint ACCOUNTOPENFILE_PK
            primary key,
    FILECONTENT       CLOB              not null,
    PROCESSID         VARCHAR2(35 char) not null,
    CREATEDUTC        TIMESTAMP(6)      not null,
    RESENTUTC         TIMESTAMP(6)
);

create table ACCOUNTSTATEMENTFILE
(
    ACCOUNTSTATEMENTFILEID     NUMBER(19)                       not null
        primary key,
    CONTENTS                   CLOB                             not null,
    TYPE                       VARCHAR2(8 char) default 'MT940' not null
        constraint ASF_TYPE_CC
            check (type IN ('MT940', 'MT942', 'CAMT.054')),
    STATEMENTNUMBER            NUMBER(10)       default 1       not null,
    RECEIVEDUTC                TIMESTAMP(6)                     not null,
    VALUEUTC                   TIMESTAMP(6)     default NULL    not null,
    MANUAL                     NUMBER(3)        default 0       not null,
    NARRATIVE                  VARCHAR2(100 char),
    SEQUENCENUMBER             NUMBER(10),
    MESSAGEID                  VARCHAR2(40 char),
    ACCOUNTIDENTIFIER          VARCHAR2(35 char),
    CONTENTSSHA1               RAW(20)
        constraint ASF_CONTENTSSHA1_CC
            check (ContentsSHA1 IS NULL OR LENGTH(ContentsSHA1) = 40),
    OPENINGBALANCE             NUMBER(19),
    INTERMEDIATEOPENINGBALANCE NUMBER(19),
    INTERMEDIATECLOSINGBALANCE NUMBER(19),
    CLOSINGBALANCE             NUMBER(19)
);

create index IDX2_ACCOUNTSTATEMENTFILE
    on ACCOUNTSTATEMENTFILE (ACCOUNTIDENTIFIER);

create index IDX3_ACCOUNTSTATEMENTFILE
    on ACCOUNTSTATEMENTFILE (CONTENTSSHA1);

create index IDX1_ACCOUNTSTATEMENTFILE
    on ACCOUNTSTATEMENTFILE (VALUEUTC);

create table ACTIVESAVINGSDOCUMENTHISTORY
(
    ASDOCUMENTID     NUMBER(19)   not null,
    FILEUPLOADID     NUMBER(19)   not null,
    TRANSACTIONID    NUMBER(19)   not null,
    EFFECTIVEDATEUTC TIMESTAMP(6) not null
);

create table ALERTAREA
(
    ALERTAREAID NUMBER(19)         not null
        primary key,
    NAME        VARCHAR2(50 char)  not null
        constraint AK1_ALERTAREA
            unique,
    DESCRIPTION VARCHAR2(255 char) not null
);

create table ALERTSOURCE
(
    ALERTSOURCEID NUMBER(19)        not null
        primary key,
    NAME          VARCHAR2(50 char) not null
        constraint AK1_ALERTSOURCE
            unique
);

create table ALERT
(
    ALERTID       NUMBER(19)                          not null
        primary key,
    STATUS        VARCHAR2(10 char) default 'PENDING' not null
        check (STATUS IN (
                          'PENDING', 'ACKNOWLEDGED'
            )),
    DESCRIPTION   VARCHAR2(255 char)                  not null,
    CREATEDUTC    TIMESTAMP(6)                        not null,
    "LEVEL"       NUMBER(10)                          not null,
    ALERTAREAID   NUMBER(19)                          not null
        constraint AA_ALERT
            references ALERTAREA,
    ALERTSOURCEID NUMBER(19)                          not null
        constraint AS_ALERT
            references ALERTSOURCE
);

create index FK2_ALERT
    on ALERT (ALERTSOURCEID);

create index FK1_ALERT
    on ALERT (ALERTAREAID);

create table ALERTACTION
(
    ALERTACTIONID NUMBER(19)         not null
        primary key,
    PROCESS       VARCHAR2(255 char) not null,
    PARAMS        VARCHAR2(255 char) not null,
    ALERTID       NUMBER(19)         not null
        constraint ALERT_AA
            references ALERT
);

comment on column ALERTACTION.PROCESS is 'URL of the process to execute';

comment on column ALERTACTION.PARAMS is 'Parameters to pass to the process to execute';

create index FK1_ALERTACTION
    on ALERTACTION (ALERTID);

create table ALERTKEYVALUE
(
    ALERTKEYVALUEID NUMBER(19)         not null
        primary key,
    ALERTID         NUMBER(19)         not null
        constraint ALERT_AKV
            references ALERT,
    KEY             VARCHAR2(100 char) not null,
    VALUE           VARCHAR2(100 char) not null,
    VALUETYPE       VARCHAR2(20 char)  not null
        check (VALUETYPE IN (
                             'Bank', 'Building Society'
            ))
);

create index FK1_ALERTKEYVALUE
    on ALERTKEYVALUE (ALERTID);

create table APPCONFIGURATION
(
    APPCONFIGURATIONID NUMBER(19)         not null
        primary key,
    NAME               VARCHAR2(50 char)  not null
        constraint AK1_APPCONFIGURATION_NAME
            unique,
    VALUE              VARCHAR2(255 char) not null,
    TYPE               VARCHAR2(10 char)  not null
        constraint AC_TYPE_CC
            check (TYPE IN ('BOOLEAN', 'STRING', 'INTEGER', 'DOUBLE')),
    DESCRIPTION        VARCHAR2(255 char) not null,
    CREATEDUTC         TIMESTAMP(6)       not null
);

create table APPCONFIGURATIONHISTORY
(
    APPCONFIGURATIONID NUMBER(19),
    TRANSACTIONID      NUMBER(19) not null,
    NAME               VARCHAR2(50 char),
    VALUE              VARCHAR2(255 char),
    TYPE               VARCHAR2(10 char),
    DESCRIPTION        VARCHAR2(255 char),
    CREATEDUTC         TIMESTAMP(6)
);

create table AUDITACTION
(
    AUDITACTIONID           NUMBER(19)         not null
        primary key,
    CREATEDUTC              TIMESTAMP(6)       not null,
    TRANSACTIONREFERENCE    VARCHAR2(50 char)  not null,
    MESSAGENAME             VARCHAR2(150 char) not null,
    INTERNALUSERID          NUMBER(19)         not null,
    CLIENTCASHACCOUNTID     NUMBER(19),
    AMOUNT                  NUMBER(19, 2),
    CUSTOMREFERENCE         VARCHAR2(150 char),
    INSTRUMENTID            NUMBER(19),
    PARTNERBANKID           NUMBER(19),
    EFFECTIVEDATE           TIMESTAMP(6),
    TARGETEXTERNALREFERENCE VARCHAR2(25 char),
    TARGETACCOUNTTYPE       VARCHAR2(2 char),
    EVENTID                 NUMBER(19),
    JOURNALID               NUMBER(19),
    FILEID                  NUMBER(19),
    TARGETINTERNALUSERID    NUMBER(19),
    SOURCE                  VARCHAR2(30 char),
    TRANSITION              VARCHAR2(30 char),
    FEATUREID               NUMBER(19),
    PAYMENTID               NUMBER(19),
    RELATEDINSTRUMENTID     NUMBER(19)
);

create index IDX_AUDITACT_TRANSACTIONREF
    on AUDITACTION (TRANSACTIONREFERENCE);

create index IDX_AUDITACT_CREATEDUTC
    on AUDITACTION (CREATEDUTC);

create index IDX_AUDITACT_CLIENTACCOUNTID
    on AUDITACTION (CLIENTCASHACCOUNTID);

create index IDX_AUDITACT_INTERNALUSERID
    on AUDITACTION (INTERNALUSERID);

create table AUDITTRANSACTION
(
    TRANSACTIONID        NUMBER(19)         not null
        primary key,
    TYPE                 VARCHAR2(255 char) not null,
    INTERNALUSERID       NUMBER(19)         not null,
    CREATEDUTC           TIMESTAMP(6)       not null,
    TRANSACTIONREFERENCE VARCHAR2(50 char),
    ACCOUNT              VARCHAR2(30 char),
    ACTION               VARCHAR2(30 char),
    SOURCE               VARCHAR2(30 char),
    MAPPERMETHOD         VARCHAR2(150 char),
    MESSAGENAME          VARCHAR2(150 char),
    CUSTOMERREFERENCE    VARCHAR2(50 char),
    SESSIONUID           VARCHAR2(50 char),
    SOURCEINFODETAILS    VARCHAR2(500 char) default ''
);

create index IDX_AUDITTRAN_CREATEDUTC
    on AUDITTRANSACTION (CREATEDUTC);

create index IDX_AUDITTRAN_CUSTOMERREF
    on AUDITTRANSACTION (CUSTOMERREFERENCE);

create index IDX_AUDITTRAN_INTERNALUSERID
    on AUDITTRANSACTION (INTERNALUSERID);

create index IDX_AUDITTRAN_TYPE
    on AUDITTRANSACTION (TYPE);

create index IDX_AUDITTRAN_TRANSACTIONREF
    on AUDITTRANSACTION (TRANSACTIONREFERENCE);

create table BANKADDRESS
(
    BANKADDRESSID NUMBER(19)        not null
        primary key,
    ADDRESSTYPE   VARCHAR2(50 char) not null
        constraint BA_ADDRESSTYPE_CC
            check (ADDRESSTYPE IN ('HEAD_OFFICE', 'BILLING')),
    ADDRESSLINE1  VARCHAR2(100 char),
    ADDRESSLINE2  VARCHAR2(100 char),
    ADDRESSLINE3  VARCHAR2(100 char),
    CITY          VARCHAR2(100 char),
    POSTCODE      VARCHAR2(8 char),
    COUNTRY       NVARCHAR2(2)      not null
        constraint BA_COUNTRY_CC
            check (country IN ('UK'))
);

create table BANKHOLIDAY
(
    BANKHOLIDAYID NUMBER(19)        not null
        primary key,
    COUNTRY       VARCHAR2(2 char)  not null
        constraint BH_COUNTRY_CC
            check (country IN ('UK')),
    HOLIDAYNAME   VARCHAR2(50 char) not null
);

create table BANKMESSAGINGPROFILE
(
    BANKMESSAGINGPROFILEID  NUMBER(19)                          not null
        primary key,
    MESSAGEINTERFACE        VARCHAR2(7 char)  default 'FILEACT' not null
        check (messageInterface in ('FIN', 'FILEACT')),
    FAMESSAGEFORMAT         VARCHAR2(8 char)  default 'BARCLAYS'
        check (FAMessageFormat in ('BARCLAYS', 'HLS')),
    FACOMPRESSION           VARCHAR2(4 char)
        check (FACompression in ('GZIP', 'ZIP', 'NONE')),
    CAMTFIELD86             VARCHAR2(15 char) default 'NONE'    not null
        check (camtField86 IN
               ('BARCLAYS-B+', 'BARCLAYS-C+', 'BARCLAYS-Z', 'NONE')),
    FPMAXPAYMENTAMOUNT      NUMBER(19, 2)                       not null,
    CHAPSMAXPAYMENTAMOUNT   NUMBER(19, 2)                       not null,
    MAXPAYMENTAMOUNTPERFILE NUMBER(19, 2)     default 250000000 not null,
    PAINGROUPINGFPS         VARCHAR2(3 char)  default '1:1'     not null
        check (painGroupingFPS in ('1:1', '1:N')),
    PAINGROUPINGBACS        VARCHAR2(3 char)  default '1:1'     not null
        check (painGroupingBACS in ('1:1', '1:N')),
    PAINGROUPINGCHAPS       VARCHAR2(3 char)  default '1:1'     not null
        check (painGroupingCHAPS in ('1:1', '1:N')),
    PAINACCOUNTIDFORMAT     VARCHAR2(4 char)  default 'BOTH'    not null
        constraint BMP_PAINACCOUNTIDFORMAT_CC
            check (painAccountIdFormat IN ('BOTH', 'BBAN'))
);

create table BANKSYNCHRONIZATIONPROCESS
(
    BANKSYNCHRONIZATIONPROCESSID NUMBER(19) not null
        primary key
);

create table BATCH_JOB_INSTANCE
(
    JOB_INSTANCE_ID NUMBER(19)         not null
        primary key,
    VERSION         NUMBER(19),
    JOB_NAME        VARCHAR2(100 char) not null,
    JOB_KEY         VARCHAR2(32 char)  not null,
    constraint JOB_INST_UN
        unique (JOB_NAME, JOB_KEY)
);

create table BATCH_JOB_EXECUTION
(
    JOB_EXECUTION_ID           NUMBER(19)   not null
        primary key,
    VERSION                    NUMBER(19),
    JOB_INSTANCE_ID            NUMBER(19)   not null
        constraint JOB_INST_EXEC_FK
            references BATCH_JOB_INSTANCE,
    CREATE_TIME                TIMESTAMP(6) not null,
    START_TIME                 TIMESTAMP(6) default NULL,
    END_TIME                   TIMESTAMP(6) default NULL,
    STATUS                     VARCHAR2(10 char),
    EXIT_CODE                  VARCHAR2(2500 char),
    EXIT_MESSAGE               VARCHAR2(2500 char),
    LAST_UPDATED               TIMESTAMP(6),
    JOB_CONFIGURATION_LOCATION VARCHAR2(2500 char)
);

create table BATCH_JOB_EXECUTION_CONTEXT
(
    JOB_EXECUTION_ID   NUMBER(19)          not null
        primary key
        constraint JOB_EXEC_CTX_FK
            references BATCH_JOB_EXECUTION,
    SHORT_CONTEXT      VARCHAR2(2500 char) not null,
    SERIALIZED_CONTEXT CLOB
);

create table BATCH_JOB_EXECUTION_PARAMS
(
    JOB_EXECUTION_ID NUMBER(19)         not null
        constraint JOB_EXEC_PARAMS_FK
            references BATCH_JOB_EXECUTION,
    TYPE_CD          VARCHAR2(6 char)   not null,
    KEY_NAME         VARCHAR2(100 char) not null,
    STRING_VAL       VARCHAR2(250 char),
    DATE_VAL         TIMESTAMP(6) default NULL,
    LONG_VAL         NUMBER(19),
    DOUBLE_VAL       NUMBER,
    IDENTIFYING      CHAR               not null
);

create table BATCH_STEP_EXECUTION
(
    STEP_EXECUTION_ID  NUMBER(19)         not null
        primary key,
    VERSION            NUMBER(19)         not null,
    STEP_NAME          VARCHAR2(100 char) not null,
    JOB_EXECUTION_ID   NUMBER(19)         not null
        constraint JOB_EXEC_STEP_FK
            references BATCH_JOB_EXECUTION,
    START_TIME         TIMESTAMP(6)       not null,
    END_TIME           TIMESTAMP(6) default NULL,
    STATUS             VARCHAR2(10 char),
    COMMIT_COUNT       NUMBER(19),
    READ_COUNT         NUMBER(19),
    FILTER_COUNT       NUMBER(19),
    WRITE_COUNT        NUMBER(19),
    READ_SKIP_COUNT    NUMBER(19),
    WRITE_SKIP_COUNT   NUMBER(19),
    PROCESS_SKIP_COUNT NUMBER(19),
    ROLLBACK_COUNT     NUMBER(19),
    EXIT_CODE          VARCHAR2(2500 char),
    EXIT_MESSAGE       VARCHAR2(2500 char),
    LAST_UPDATED       TIMESTAMP(6)
);

create table BATCH_STEP_EXECUTION_CONTEXT
(
    STEP_EXECUTION_ID  NUMBER(19)          not null
        primary key
        constraint STEP_EXEC_CTX_FK
            references BATCH_STEP_EXECUTION,
    SHORT_CONTEXT      VARCHAR2(2500 char) not null,
    SERIALIZED_CONTEXT CLOB
);

create table BFCURRENCY
(
    CURRENCYID VARCHAR2(3 char) default 'GBP' not null
        primary key
        constraint BFC_CURRENCYID_CC
            check (currencyid IN ('GBP')),
    BFCURRENCY VARCHAR2(2 char)               not null
        constraint AK1_BFCURRENCY
            unique
);

create table CARDPAYMENTHISTORY
(
    CARDPAYMENTID  NUMBER(19),
    TRANSACTIONID  NUMBER(19),
    TAGID          VARCHAR2(50 char),
    AUTHCODE       VARCHAR2(50 char),
    PROVIDER       VARCHAR2(30 char),
    REQUESTEDUTC   TIMESTAMP(6),
    AUTHUTC        TIMESTAMP(6),
    PANDETAILS     VARCHAR2(4 char),
    CASHACCOUNTID  NUMBER(19),
    GENERICORDERID NUMBER(19),
    MARK           VARCHAR2(2 char)
);

create table CASHACCOUNTBALANCEHISTORY
(
    CASHACCOUNTBALANCEID NUMBER(19),
    TRANSACTIONID        NUMBER(19) not null,
    CASHACCOUNTID        NUMBER(19),
    AMOUNT               NUMBER(19, 2),
    VALUEUTC             TIMESTAMP(6),
    ORDINAL              NUMBER(19)
);

create table CASHACCOUNTHISTORY
(
    CASHACCOUNTID       NUMBER(19)              not null,
    TRANSACTIONID       NUMBER(19)              not null,
    CUSTOMERID          NUMBER(19),
    BANKACCOUNTID       NUMBER(19),
    CASHACCOUNTTYPEID   NUMBER(19),
    PARENTCASHACCOUNTID NUMBER(19),
    INSTRUMENTID        NUMBER(19),
    AMOUNT              NUMBER(19, 2),
    AATI                NUMBER(19, 2),
    AATW                NUMBER(19, 2),
    AATT                NUMBER(19, 2),
    UPDATEDUTC          TIMESTAMP(6),
    CREATEDUTC          TIMESTAMP(6),
    STATUS              VARCHAR2(15 char),
    TAATI               NUMBER(19, 2) default 0 not null,
    TAATW               NUMBER(19, 2) default 0 not null,
    TAATT               NUMBER(19, 2) default 0 not null,
    DEFAULTSPSWEEPUTC   TIMESTAMP(6)  default NULL,
    PSD2WHITELISTEDUTC  TIMESTAMP(6)  default NULL
);

create table CASHACCOUNTTYPE
(
    CASHACCOUNTTYPEID NUMBER(19)                     not null
        primary key,
    CURRENCY          VARCHAR2(3 char) default 'GBP' not null
        constraint CURR_CAT
            references BFCURRENCY,
    ACCOUNTTYPE       VARCHAR2(2 char)               not null
        constraint AK1_CASHACCOUNTTYPE
            unique
        constraint CA_ACCOUNTTYPE_CC
            check (accountType IN ('IB', 'IN', 'IX'))
);

create index FK1_CASHACCOUNTTYPE
    on CASHACCOUNTTYPE (CURRENCY);

create table CASHMOVEMENTHISTORY
(
    CASHMOVEMENTID NUMBER(19) not null,
    TRANSACTIONID  NUMBER(19) not null,
    CASHACCOUNTID  NUMBER(19) not null,
    MARK           VARCHAR2(2 char),
    CREATEDUTC     TIMESTAMP(6)
);

create table CLEARINGCALENDAREXCEPTION
(
    CLEARINGCALENDAREXID NUMBER(19) not null
        primary key,
    BANKHOLIDAYID        NUMBER(19) not null
        constraint BH_CCALEX
            references BANKHOLIDAY,
    HOLIDAYDATE          DATE       not null,
    EXCEPTIONNAME        VARCHAR2(50 char)
);

create index FK1_CLEARINGCALENDAREXCEPTION
    on CLEARINGCALENDAREXCEPTION (BANKHOLIDAYID);

create table CLEARINGCALENDAREXHISTORY
(
    CLEARINGCALENDAREXID NUMBER(19) not null,
    TRANSACTIONID        NUMBER(19) not null,
    BANKHOLIDAYID        NUMBER(19) not null,
    HOLIDAYDATE          DATE       not null,
    EXCEPTIONNAME        VARCHAR2(50 char)
);

create table CUSTOMER
(
    CUSTOMERID        NUMBER(19)                         not null
        primary key,
    EXTERNALREFERENCE VARCHAR2(25 char)                  not null
        constraint AK1_CUSTOMER
            unique,
    CUSTOMERTYPE      VARCHAR2(11 char)                  not null
        constraint C_CUSTOMERTYPE_CC
            check (customerType IN ('EXTERNAL', 'INTERNAL', 'PARTNERBANK')),
    CUSTOMERTESTTYPE  VARCHAR2(11 char) default 'NORMAL' not null
        check (customerTestType in ('NORMAL', 'TEST'))
);

create table FEATURE
(
    FEATUREID   NUMBER(19)                           not null
        primary key,
    NAME        VARCHAR2(50 char)                    not null
        constraint AK1_FEATURE_NAME
            unique,
    DESCRIPTION VARCHAR2(255 char)                   not null,
    STATUS      VARCHAR2(50 char) default 'DISABLED' not null
        constraint F_STATUS_CC
            check (status IN ('DISABLED', 'RESTRICTED', 'ENABLED'))
);

create table CUSTOMER2FEATURE
(
    CUSTOMERID NUMBER(19) not null
        constraint CUS_CUS2FEA
            references CUSTOMER,
    FEATUREID  NUMBER(19) not null
        constraint FEA_CUS2FEA
            references FEATURE
);

create table FEATURETOGGLE
(
    FEATURETOGGLEID NUMBER(19)          not null
        primary key,
    FEATURE         VARCHAR2(25 char)   not null,
    APPLICATION     VARCHAR2(25 char)   not null,
    TOGGLE          VARCHAR2(25 char)   not null
        constraint FEATURETOGGLE_UNIQUE
            unique,
    DISABLED        NUMBER(3) default 1 not null
        constraint FT_ENABLED_CC
            check (disabled in (0, 1))
);

create table FILEUPLOAD
(
    FILEUPLOADID NUMBER(19)         not null
        primary key,
    FILENAME     VARCHAR2(255 char) not null,
    EXTENSION    VARCHAR2(4 char)   not null,
    FILETYPE     VARCHAR2(16 char)  not null
        constraint FU_FILETYPE_CC
            check (fileType IN
                   ('AGM_REPORT', 'AS_T_CS', 'INSTRUMENT_T_CS', 'BANK_T_CS', 'FSCS_DISCLOSURE', 'BANK_LOGO',
                    'BANK_SUMMARY_BOX', 'BANK_FACTSHEET', 'OTHER')),
    DATA         BLOB               not null,
    CREATEDUTC   TIMESTAMP(6)       not null,
    FILEPUBLICID VARCHAR2(22 char)  not null
        unique,
    DOCUMENTNAME VARCHAR2(50 char) default NULL,
    VERSION      NUMBER(19, 2)     default 1.0
);

create table ACTIVESAVINGSDOCUMENT
(
    ASDOCUMENTID     NUMBER(19)   not null
        primary key,
    FILEUPLOADID     NUMBER(19)   not null
        constraint FU_ASD
            references FILEUPLOAD,
    EFFECTIVEDATEUTC TIMESTAMP(6) not null
);

create index FK1_ACTIVESAVINGSDOCUMENT
    on ACTIVESAVINGSDOCUMENT (FILEUPLOADID);

create table FUNDINGORDERHISTORY
(
    FUNDINGORDERID NUMBER(19),
    TRANSACTIONID  NUMBER(19) not null,
    INSTRUMENTID   NUMBER(19),
    MARKATPOOLED   VARCHAR2(2 char),
    STATUS         VARCHAR2(22 char),
    UPDATEDUTC     TIMESTAMP(6),
    GENERICORDERID NUMBER(19)
);

create table GENERICORDER
(
    GENERICORDERID NUMBER(19)        not null
        constraint PK_GENERICORDER
            primary key,
    AMOUNT         NUMBER(19, 2)     not null,
    ORDERREFERENCE VARCHAR2(16 char) not null,
    CREATEDUTC     TIMESTAMP(6)      not null
);

create unique index AK1_GENERICORDER
    on GENERICORDER (ORDERREFERENCE);

create table GENERICORDERHISTORY
(
    GENERICORDERID NUMBER(19),
    TRANSACTIONID  NUMBER(19) not null,
    AMOUNT         NUMBER(19, 2),
    ORDERREFERENCE VARCHAR2(16 char),
    CREATEDUTC     TIMESTAMP(6)
);

create table HLPRODUCTLIMIT
(
    HLPRODUCTLIMITID        NUMBER(19)                     not null
        primary key,
    MINIMUMCASHBALANCE      NUMBER(19, 2) default 10       not null,
    MINIMUMOPENINGBALANCE   NUMBER(19, 2)                  not null,
    MINIMUMDCTOPUP          NUMBER(19, 2) default 10       not null,
    MINIMUMCASHTRANSFER     NUMBER(19, 2) default 10       not null,
    MINIMUMWITHDRAWALAMOUNT NUMBER(19, 2) default 1        not null,
    MAXIMUMWITHDRAWALAMOUNT NUMBER(19, 2) default 100000   not null,
    MAXIMUMDCTOPUP          NUMBER(19, 2) default 99999.99 not null,
    MINIMUMPAYBYBANKTOPUP   NUMBER(19, 2) default 1        not null,
    MAXIMUMPAYBYBANKTOPUP   NUMBER(19, 2) default 1000000  not null
);

comment on column HLPRODUCTLIMIT.MINIMUMCASHBALANCE is 'Minimum cash balance for the HUB account';

comment on column HLPRODUCTLIMIT.MINIMUMOPENINGBALANCE is 'Minimum opening balance for the HUB account';

comment on column HLPRODUCTLIMIT.MINIMUMDCTOPUP is 'Minimum DC top-up';

comment on column HLPRODUCTLIMIT.MINIMUMCASHTRANSFER is 'Minimum internal cash transfer amount';

comment on column HLPRODUCTLIMIT.MINIMUMWITHDRAWALAMOUNT is 'Minimum amount allowed to with withdrawn';

comment on column HLPRODUCTLIMIT.MAXIMUMWITHDRAWALAMOUNT is 'Maximum amount to be withdrawn';

comment on column HLPRODUCTLIMIT.MAXIMUMDCTOPUP is 'It specifies the maximum DC top-up amount';

comment on column HLPRODUCTLIMIT.MINIMUMPAYBYBANKTOPUP is 'Minimum Pay-by-Bank top-up amount';

comment on column HLPRODUCTLIMIT.MAXIMUMPAYBYBANKTOPUP is 'Maximum Pay-by-Bank top-up amount';

create table HLPRODUCTLIMITHISTORY
(
    TRANSACTIONID           NUMBER(19),
    HLPRODUCTLIMITID        NUMBER(19),
    MINIMUMCASHBALANCE      NUMBER(19, 2),
    MINIMUMOPENINGBALANCE   NUMBER(19, 2),
    MINIMUMDCTOPUP          NUMBER(19, 2),
    MAXIMUMDCTOPUP          NUMBER(19, 2),
    MINIMUMCASHTRANSFER     NUMBER(19, 2),
    MINIMUMWITHDRAWALAMOUNT NUMBER(19, 2),
    MAXIMUMWITHDRAWALAMOUNT NUMBER(19, 2),
    MINIMUMPAYBYBANKTOPUP   NUMBER(19, 2),
    MAXIMUMPAYBYBANKTOPUP   NUMBER(19, 2)
);

comment on column HLPRODUCTLIMITHISTORY.MINIMUMCASHBALANCE is 'Minimum cash balance for the HUB account';

comment on column HLPRODUCTLIMITHISTORY.MINIMUMOPENINGBALANCE is 'Minimum opening balance for the HUB account';

comment on column HLPRODUCTLIMITHISTORY.MINIMUMDCTOPUP is 'Minimum DC top-up';

comment on column HLPRODUCTLIMITHISTORY.MAXIMUMDCTOPUP is 'It specifies the maximum DC top-up amount';

comment on column HLPRODUCTLIMITHISTORY.MINIMUMCASHTRANSFER is 'Minimum internal cash transfer amount';

comment on column HLPRODUCTLIMITHISTORY.MINIMUMWITHDRAWALAMOUNT is 'Minimum amount allowed to with withdrawn';

comment on column HLPRODUCTLIMITHISTORY.MAXIMUMWITHDRAWALAMOUNT is 'Maximum amount to be withdrawn';

comment on column HLPRODUCTLIMITHISTORY.MINIMUMPAYBYBANKTOPUP is 'Minimum Pay-by-Bank top-up amount';

comment on column HLPRODUCTLIMITHISTORY.MAXIMUMPAYBYBANKTOPUP is 'Maximum Pay-by-Bank top-up amount';

create table INSTRUCTIONORDERHISTORY
(
    INSTRUCTIONORDERID     NUMBER(19) not null,
    TRANSACTIONID          NUMBER(19) not null,
    CASHACCOUNTID          NUMBER(19),
    INSTRUMENTID           NUMBER(19),
    MARK                   VARCHAR2(2 char),
    TIMEINFORCE            VARCHAR2(5 char),
    STATUS                 VARCHAR2(20 char),
    UPDATEDUTC             TIMESTAMP(6),
    PRESYNCCHECKSPASSEDUTC TIMESTAMP(6),
    GENERICORDERID         NUMBER(19),
    PRESYNCFAILUREREASON   VARCHAR2(255 char),
    ACTIONONBEHALFBYID     NUMBER(19),
    ACTIONONBEHALFSOURCE   VARCHAR2(15 char),
    ORDERTYPE              VARCHAR2(16 char) default NULL
);

create table INSTRUMENTDETAILHISTORY
(
    INSTRUMENTDETAILID          NUMBER(19),
    TRANSACTIONID               NUMBER(19)        not null,
    INSTRUMENTID                NUMBER(19),
    INSTRUMENTNAME              VARCHAR2(200 char),
    DESCRIPTION                 CLOB,
    STATUS                      VARCHAR2(36 char),
    LENGTHOFTERM                NUMBER(10),
    AER                         NUMBER(19, 10),
    GROSSRATE                   NUMBER(19, 10),
    INTERESTTYPE                VARCHAR2(10 char) not null,
    INTERESTFREQUENCY           VARCHAR2(9 char),
    CURRENCYCODE                VARCHAR2(3 char),
    MINIMUMINVESTMENT           NUMBER(19, 2),
    MAXIMUMINVESTMENT           NUMBER(19, 2),
    MINIMUMBALANCE              NUMBER(19, 2),
    MAXIMUMBALANCE              NUMBER(19, 2),
    CANWITHDRAW                 NUMBER(3),
    WITHDRAWALFEE               NUMBER(10),
    MATURITYELIGIBLE            NUMBER(3),
    COOLINGOFFPERIOD            NUMBER(10),
    COOLINGOFFTOPUP             NUMBER(3),
    FROMDATEUTC                 TIMESTAMP(6),
    TODATEUTC                   TIMESTAMP(6),
    INVESTMENTSTARTDATEUTC      TIMESTAMP(6),
    INVESTMENTENDDATEUTC        TIMESTAMP(6),
    OPENSETTLEMENTPERIOD        VARCHAR2(9 char),
    CLOSESETTLEMENTPERIOD       VARCHAR2(9 char),
    FUNDINGCAP                  NUMBER(19, 2),
    ACTIONDATEUTC               TIMESTAMP(6),
    ACTIONREASON                CLOB,
    MINIMUMWITHDRAWAL           NUMBER(19, 2),
    MAXIMUMWITHDRAWAL           NUMBER(19, 2),
    CREATEDBYUSERID             NUMBER(19)        not null,
    CREATEDUTC                  TIMESTAMP(6)      not null,
    LASTUPDATEDBYUSERID         NUMBER(19)        not null,
    LASTUPDATEDUTC              TIMESTAMP(6)      not null,
    EFFECTIVEDATEUTC            TIMESTAMP(6),
    COOLINGOFFPARTIALWITHDRAWAL NUMBER(3) default 0,
    PARTNERBANKINTERESTRATE     NUMBER(19, 10),
    COMPOUNDINGINTEREST         NUMBER(3) default 0,
    TOPUPRESTRICTED             NUMBER(3) default 0,
    PENALTYFREEWITHDRAWALS      NUMBER(10),
    PENALTYDAYS                 NUMBER(10),
    BONUSRATE                   NUMBER(19, 10),
    BONUSRATEENDDATE            DATE
);

create table INSTRUMENTHISTORY
(
    INSTRUMENTID           NUMBER(19),
    TRANSACTIONID          NUMBER(19) not null,
    PARTNERBANKID          NUMBER(19),
    PRODUCTID              NUMBER(19),
    EXTERNALREFERENCE      VARCHAR2(35 char),
    TESTPRODUCT            NUMBER(3),
    FROMTEMPLATE           NUMBER(3),
    TEMPLATENAME           VARCHAR2(50 char),
    TEMPLATEVERSION        NUMBER(19),
    PRIVATEOFFERING        NUMBER(3) default 0,
    HLPRODUCTID            NUMBER(19),
    INVISIBLEINLATESTRATES NUMBER(3) default 0,
    PARENTINSTRUMENTID     NUMBER(19)
);

create table INSTRUMENTTEMPLATEHISTORY
(
    INSTRUMENTTEMPLATEID NUMBER(19)          not null,
    TRANSACTIONID        NUMBER(19)          not null,
    PARTNERBANKID        NUMBER(19)          not null,
    CREATEDBYUSERID      NUMBER(19)          not null,
    TEMPLATENAME         VARCHAR2(50 char)   not null,
    LENGTHOFTERM         NUMBER(10)          not null,
    INTERESTTYPE         VARCHAR2(5 char)    not null,
    INTERESTFREQUENCY    VARCHAR2(9 char),
    CURRENCYCODE         VARCHAR2(3 char),
    MINIMUMBALANCE       NUMBER(19, 2)       not null,
    MAXIMUMBALANCE       NUMBER(19, 2)       not null,
    COOLINGOFFPERIOD     NUMBER(10),
    CREATEDUTC           TIMESTAMP(6)        not null,
    PRODUCTID            NUMBER(19)          not null,
    TEMPLATEVERSION      NUMBER(19),
    COMPOUNDINGINTEREST  NUMBER(3) default 0,
    PRIVATEOFFERING      NUMBER(1) default 0 not null
);

create table INTERESTORDERHISTORY
(
    INTERESTORDERID NUMBER(19)        not null,
    TRANSACTIONID   NUMBER(19)        not null,
    CASHACCOUNTID   NUMBER(19)        not null,
    INSTRUMENTID    NUMBER(19)        not null,
    STATUS          VARCHAR2(30 char) not null,
    UPDATEDUTC      TIMESTAMP(6)      not null,
    GENERICORDERID  NUMBER(19)
);

create table INTERNALUSER
(
    INTERNALUSERID NUMBER(19)         not null
        primary key,
    USERNAME       VARCHAR2(50 char)  not null,
    FIRSTNAME      VARCHAR2(50 char)  not null,
    SURNAME        VARCHAR2(50 char)  not null,
    PHONENUMBER    VARCHAR2(20 char),
    EMAILADDRESS   VARCHAR2(255 char) not null,
    JOBTITLE       VARCHAR2(50 char),
    STATUS         VARCHAR2(8 char)   not null
        constraint IU_STATUS_CC
            check (status IN ('ACTIVE', 'INACTIVE')),
    NOTES          CLOB,
    TOKEN          VARCHAR2(500 char)
);

create unique index AK1_INTERNALUSER
    on INTERNALUSER (USERNAME);

create table INTERNALUSERHISTORY
(
    INTERNALUSERID NUMBER(19),
    TRANSACTIONID  NUMBER(19),
    USERNAME       VARCHAR2(50 char),
    FIRSTNAME      VARCHAR2(50 char),
    SURNAME        VARCHAR2(50 char),
    PHONENUMBER    VARCHAR2(20 char),
    EMAILADDRESS   VARCHAR2(255 char),
    JOBTITLE       VARCHAR2(50 char),
    STATUS         VARCHAR2(8 char),
    NOTES          CLOB,
    TOKEN          VARCHAR2(500 char)
);

create table IO2SPHISTORY
(
    SYNCHRONIZATIONPROCESSID NUMBER(19),
    INSTRUCTIONORDERID       NUMBER(19),
    TRANSACTIONID            NUMBER(19)
);

create table ISATRANSFERORDERHISTORY
(
    ISATRANSFERORDERID NUMBER(19) not null,
    TRANSACTIONID      NUMBER(19) not null,
    CASHACCOUNTID      NUMBER(19),
    GENERICORDERID     NUMBER(19),
    CREATEDBYID        NUMBER(19),
    APPROVEDBYID       NUMBER(19),
    MARK               VARCHAR2(1 char),
    ISCHEQUE           NUMBER(3),
    PROVIDER           VARCHAR2(100 char),
    ACCOUNTNAME        VARCHAR2(100 char),
    ACCOUNTIDENTIFIER  VARCHAR2(35 char),
    TRANSFERREFERENCE  VARCHAR2(100 char),
    STATUS             VARCHAR2(16 char),
    TYPE               VARCHAR2(17 char),
    REJECTEDCOUNTER    NUMBER(10)
);

create global temporary table JH
(
    JOURNALID   NUMBER,
    CREATEDBYID NUMBER
)
    on commit delete rows;

create table JMSMESSAGE
(
    JMSMESSAGEID  NUMBER(19)         not null
        primary key,
    ORIGDATA      CLOB               not null,
    MESSAGETYPE   VARCHAR2(50 char)  not null,
    QUEUENAME     VARCHAR2(255 char) not null,
    DIRECTION     VARCHAR2(10 char)  not null
        constraint JMS_DIRECTION_CC
            check (direction in ('SENT', 'RECEIVED')),
    CREATEDUTC    TIMESTAMP(6)       not null,
    CORRELATIONID VARCHAR2(50 char)
);

create table JOURNALENTRYHISTORY
(
    JOURNALENTRYID     NUMBER(19),
    JOURNALID          NUMBER(19),
    TRANSACTIONID      NUMBER(19),
    ORDINAL            NUMBER(19),
    AMOUNT             NUMBER(19, 2),
    STATUS             VARCHAR2(10 char),
    MOVEMENTTYPE       VARCHAR2(15 char),
    MOVEMENTSUBTYPE    VARCHAR2(20 char),
    REFERENCE          VARCHAR2(35 char),
    CREATEDUTC         TIMESTAMP(6),
    VALUEUTC           TIMESTAMP(6),
    PROCESSINGSTARTUTC TIMESTAMP(6),
    RECONCILEDUTC      TIMESTAMP(6),
    FROMCASHMOVEMENTID NUMBER(19),
    TOCASHMOVEMENTID   NUMBER(19),
    NARRATIVE          VARCHAR2(100 char),
    CREATEDBYID        NUMBER(19)
);

create table JOURNALGROUP
(
    JOURNALGROUPID NUMBER(19)   not null
        constraint PK_JOURNALGROUP
            primary key,
    CREATEDUTC     TIMESTAMP(6) not null
);

create table JOURNAL
(
    JOURNALID      NUMBER(19)              not null
        constraint PK_JOURNAL
            primary key,
    CREATEDUTC     TIMESTAMP(6)            not null,
    JOURNALTYPE    VARCHAR2(15 char)       not null
        constraint J_TYPE_CC
            check (journalType IN
                   ('TOPUP', 'WITHDRAWAL', 'TRANSFER', 'MATURITY', 'SYNC', 'INTEREST', 'FEE', 'ROUNDING', 'ISATRANSFER',
                    'PENALTY')),
    JOURNALSUBTYPE VARCHAR2(15 char)       not null
        constraint J_SUBTYPE_CC
            check (journalSubType IN
                   ('CHEQUE', 'DEBITCARD', 'BANKTRANSFER', 'WITHDRAWAL', 'HLAMTOHLS', 'HLSTOHLAM', 'HLSTOHLS',
                    'MATURITYV1', 'MATURITYV2', 'TOPUPV1', 'TOPUPV2', 'SYNCV1', 'SYNCV2', 'WITHDRAWV1', 'WITHDRAWV2',
                    'INTERESTV1FTD', 'INTERESTV1EA', 'INTERESTV2FTD', 'INTERESTV2EA', 'FEE', 'ROUNDING', 'ISACHEQUE',
                    'ISABANKTRANSFER', 'PENALTYV1LA', 'ROLLOVER', 'PENALTYV1FTD')),
    STATUS         VARCHAR2(15 char)       not null
        constraint J_STATUS_CC
            check (Status IN ('PENDING', 'BOOKED', 'POSTED', 'REVERSED', 'DRAFTREVERSE', 'DRAFT')),
    BOOKEDUTC      TIMESTAMP(6),
    JOURNALGROUPID NUMBER(19)              not null
        constraint JG_J
            references JOURNALGROUP,
    CREATEDBYID    NUMBER(19) default '-1' not null
        constraint IU_J
            references INTERNALUSER,
    REVERSEDUTC    TIMESTAMP(6)
);

create index IDX3_JOURNAL
    on JOURNAL (CREATEDBYID);

create index FK1_JOURNALGROUPID
    on JOURNAL (JOURNALGROUPID);

create index IDX1_JOURNAL
    on JOURNAL (STATUS);

create table JOURNALGROUPHISTORY
(
    JOURNALGROUPID NUMBER(19),
    TRANSACTIONID  NUMBER(19),
    CREATEDUTC     TIMESTAMP(6)
);

create table JOURNALHISTORY
(
    JOURNALID      NUMBER(19),
    TRANSACTIONID  NUMBER(19),
    CREATEDUTC     TIMESTAMP(6),
    JOURNALTYPE    VARCHAR2(15 char),
    JOURNALSUBTYPE VARCHAR2(15 char),
    STATUS         VARCHAR2(15 char),
    BOOKEDUTC      TIMESTAMP(6),
    JOURNALGROUPID NUMBER(19),
    CREATEDBYID    NUMBER(19) default '-1' not null,
    REVERSEDUTC    TIMESTAMP(6)
);

create table MT940SCHEDULE
(
    MT940SCHEDULEID NUMBER(19) not null
        constraint MT940_PK
            primary key,
    MONDAY          NUMBER(3)  not null
        check (monday in (0, 1)),
    TUESDAY         NUMBER(3)  not null
        check (tuesday in (0, 1)),
    WEDNESDAY       NUMBER(3)  not null
        check (wednesday in (0, 1)),
    THURSDAY        NUMBER(3)  not null
        check (thursday in (0, 1)),
    FRIDAY          NUMBER(3)  not null
        check (friday in (0, 1)),
    SATURDAY        NUMBER(3)  not null
        check (saturday in (0, 1)),
    SUNDAY          NUMBER(3)  not null
        check (sunday in (0, 1)),
    constraint MT940_DAY
        unique (MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY)
);

create table PARTNERBANK2FILEUPLOAD
(
    PARTNERBANKID NUMBER(19) not null,
    FILEUPLOADID  NUMBER(19) not null,
    primary key (PARTNERBANKID, FILEUPLOADID)
);

create index FK2_PARTNERBANK2FILEUPLOAD
    on PARTNERBANK2FILEUPLOAD (PARTNERBANKID);

create index FK1_PARTNERBANK2FILEUPLOAD
    on PARTNERBANK2FILEUPLOAD (FILEUPLOADID);

create table PARTNERBANKDETAILSHISTORY
(
    PARTNERBANKDETAILSID       NUMBER(19),
    TRANSACTIONID              NUMBER(19),
    PARTNERBANKID              NUMBER(19),
    BANKADDRESSID              NUMBER(19),
    PARTNERBANKDETAILSSTATUS   VARCHAR2(50 char),
    DISPLAYNAME                VARCHAR2(50 char),
    BANKINGLICENCE             VARCHAR2(100 char),
    PARENTDOMICILE             VARCHAR2(50 char),
    REGULATOR                  VARCHAR2(50 char),
    DEPOSITGUARANTEESCHEME     VARCHAR2(50 char),
    FOUNDINGYEAR               NUMBER(4),
    NUMBEROFSTAFF              NUMBER(10),
    REVENUE                    NUMBER(19, 2),
    REVENUECORRECTAT           DATE,
    PROFITBEFORETAX            NUMBER(19, 2),
    PROFITBEFORETAXCORRECTAT   DATE,
    TOTALDEPOSITS              NUMBER(19, 2),
    TOTALDEPOSITSCORRECTAT     DATE,
    TIER1CAPITALRATIO          NUMBER(19, 9),
    TIER1CAPITALRATIOCORRECTAT DATE,
    LEVERAGERATIO              NUMBER(19, 9),
    LEVERAGERATIOCORRECTAT     DATE,
    CREDITRATINGAGENCY         VARCHAR2(50 char),
    CREDITRATING               VARCHAR2(4 char),
    CREDITRATINGCORRECTAT      DATE,
    INFONOTES                  CLOB,
    LOGO                       NUMBER(19),
    CREATEDBYUSERID            NUMBER(19)   not null,
    CREATEDUTC                 TIMESTAMP(6) not null,
    LASTUPDATEDBYUSERID        NUMBER(19)   not null,
    LASTUPDATEDUTC             TIMESTAMP(6) not null,
    BILLINGMETHOD              VARCHAR2(14 char),
    BILLINGADDRESSID           NUMBER(19),
    BILLINGCONTACTNAME         VARCHAR2(100 char),
    BILLINGEMAILADDRESS        VARCHAR2(100 char)
);

create table PARTNERBANKPERMISSIONHISTORY
(
    PARTNERBANKPERMISSIONID      NUMBER(19)          not null,
    PARTNERBANKID                NUMBER(19)          not null,
    EASYACCESSISAPRODUCTSENABLED NUMBER(1)           not null,
    FIXEDTERMISAPRODUCTSENABLED  NUMBER(1)           not null,
    TRANSACTIONID                NUMBER(19)          not null,
    LIMITEDACCESSISAENABLED      NUMBER(1) default 0 not null,
    LIMITEDACCESSASENABLED       NUMBER(1) default 0 not null,
    FIXEDTERMROLLOVERENABLED     NUMBER(1) default 0 not null
);

create table PARTNERBANKSYNCMODEL
(
    PARTNERBANKSYNCMODELID        NUMBER(19)         not null
        constraint PK_PARTNERBANKSYNCMODEL
            primary key,
    PROFILE                       VARCHAR2(4 char)   not null
        constraint AK1_PARTNERBANKSYNCMODEL
            unique
        constraint PBSM_PROFILE_CC
            check (profile IN
                   ('V1.1', 'V1.2', 'V1.3', 'V1.4', 'V1.5', 'V1.6', 'V2.1', 'V2.2', 'V2.3', 'V2.4', 'V2.5', 'V2.6',
                    'V2.7')),
    POOLEDACCOUNTLOCATION         VARCHAR2(29 char)  not null
        constraint PBSM_POOLEDACCOUNTLOCATION_CC
            check (pooledAccountLocation IN ('CLEARERBANK', 'PARTNERBANK')),
    SYNCMETHOD                    VARCHAR2(12 char)  not null
        check (SYNCMETHOD IN ('AUTOMATED', 'MANUAL')),
    BANKPROFILE                   VARCHAR2(29 char)  not null
        constraint PBSM_BANKPROFILE_CC
            check (bankProfile IN ('V1', 'V2')),
    SETTLEMENTACCOUNT             NUMBER(3)          not null
        check (SETTLEMENTACCOUNT IN (0, 1)),
    CLIENTBREAKDOWN               NUMBER(3)          not null
        check (CLIENTBREAKDOWN IN (0, 1)),
    SUPPORTSINITIALACCOUNTFUNDING NUMBER(3)          not null
        check (SUPPORTSINITIALACCOUNTFUNDING IN (0, 1)),
    DESCRIPTION                   VARCHAR2(100 char) not null
);

create table PARTNERBANK
(
    PARTNERBANKID          NUMBER(19)        not null
        primary key,
    BANKNAME               VARCHAR2(50 char) not null
        constraint AK1_PARTNERBANK
            unique,
    ENTITYTYPE             VARCHAR2(20 char)
        constraint PB_ENTITYTYPE_CC
            check (entityType IN ('Bank', 'Building Society')),
    BIC                    VARCHAR2(11 char) not null
        constraint AK2_PARTNERBANK
            unique
        constraint PB_BIC_CC
            check (LENGTH(bic) = 8 OR LENGTH(bic) = 11),
    FIRMREFERENCENUMBER    NUMBER(20),
    STATUS                 VARCHAR2(8 char)  not null
        constraint PB_STATUS_CC
            check (status IN ('ACTIVE', 'INACTIVE')),
    NOTES                  CLOB,
    BANKMESSAGINGPROFILEID NUMBER(19)        not null
        constraint PB_BMP
            references BANKMESSAGINGPROFILE,
    PARTNERBANKSYNCMODELID NUMBER(19)        not null
        constraint PB_PBSM
            references PARTNERBANKSYNCMODEL,
    MT940SCHEDULEID        NUMBER(19)
        constraint FK_PB_MT940
            references MT940SCHEDULE,
    MAXORDERSPERSYNC       NUMBER(19),
    PARTNERBANKPUBLICID    VARCHAR2(24 char) not null
        constraint PARTNER_BANK_PUBLIC_ID_UNIQUE
            unique
);

create table ALERTEVENT
(
    EVENTID             NUMBER(19)         not null
        primary key,
    EVENTDATETIMEUTC    TIMESTAMP(6)       not null,
    EVENTTYPE           VARCHAR2(50 char)  not null,
    SUBTYPE             VARCHAR2(100 char) not null,
    SOURCE              VARCHAR2(50 char)  not null,
    PARTNERBANKID       NUMBER(19)
        constraint PB_ACE
            references PARTNERBANK,
    SUMMARYDESCRIPTION  VARCHAR2(512 char) not null,
    DETAILEDDESCRIPTION CLOB,
    TARGET              VARCHAR2(4 char)   not null
        constraint AE_TARGET_CC
            check (target IN ('SAFE', 'ASP')),
    ACKNOWLEDGEDBY      VARCHAR2(50 char),
    ACKNOWLEDGEDUTC     TIMESTAMP(6)
);

create index FK1_ALERTEVENT
    on ALERTEVENT (PARTNERBANKID);

create table ALERTHREF
(
    ALERTHREFID NUMBER(19)         not null
        primary key,
    EVENTID     NUMBER(19)         not null
        constraint AH_AH2AE
            references ALERTEVENT,
    HREF        VARCHAR2(250 char) not null
);

create table CIFASREPORT
(
    CIFASREPORTID        NUMBER(19)             not null
        constraint PK_CIFASREPORT
            primary key,
    PARTNERBANKID        NUMBER(19)             not null
        constraint AK1_CIFASREPORT
            unique
        constraint PB_CR
            references PARTNERBANK,
    DATA                 BLOB,
    REQUESTEDUTC         TIMESTAMP(6)           not null,
    COMPLETEDUTC         TIMESTAMP(6),
    FAILED               NUMBER(1)    default 0 not null
        constraint FAILED_BOOLEAN_CIFASREPORT
            check (failed IN (0, 1)),
    PREVIOUSCOMPLETEDUTC TIMESTAMP(6) default NULL
);

create index FK2_PARTNERBANK
    on PARTNERBANK (PARTNERBANKSYNCMODELID);

create index FK1_PARTNERBANK
    on PARTNERBANK (BANKMESSAGINGPROFILEID);

create table PARTNERBANKDETAILS
(
    PARTNERBANKDETAILSID       NUMBER(19)                          not null
        primary key,
    BANKADDRESSID              NUMBER(19)                          not null
        constraint BA_PBD
            references BANKADDRESS,
    PARTNERBANKID              NUMBER(19)                          not null
        constraint PB_PBD
            references PARTNERBANK,
    LOGO                       NUMBER(19)                          not null
        constraint FU_PBD
            references FILEUPLOAD,
    PARTNERBANKDETAILSSTATUS   VARCHAR2(50 char) default 'PENDING' not null
        constraint PBD_STATUS_CC
            check (partnerBankDetailsStatus IN
                   ('PUBLISHED', 'PENDING', 'PENDING_REVIEW_BY_SECOND_USER', 'SUBMITTED_TO_HL_FOR_REVIEW',
                    'REJECTED_BY_SECOND_USER', 'ARCHIVED', 'REJECTED_BY_HL')),
    DISPLAYNAME                VARCHAR2(50 char)                   not null,
    BANKINGLICENCE             VARCHAR2(100 char),
    PARENTDOMICILE             VARCHAR2(50 char),
    REGULATOR                  VARCHAR2(50 char)
        constraint PBD_REGULATOR_CC
            check (regulator IN ('FCA')),
    DEPOSITGUARANTEESCHEME     VARCHAR2(50 char)
        constraint PBD_DEPOSITGUARANTEESCHEME_CC
            check (depositGuaranteeScheme IN ('FSCS')),
    FOUNDINGYEAR               NUMBER(4),
    NUMBEROFSTAFF              NUMBER(10),
    REVENUE                    NUMBER(19, 2),
    REVENUECORRECTAT           DATE,
    PROFITBEFORETAX            NUMBER(19, 2),
    PROFITBEFORETAXCORRECTAT   DATE,
    TOTALDEPOSITS              NUMBER(19, 2),
    TOTALDEPOSITSCORRECTAT     DATE,
    TIER1CAPITALRATIO          NUMBER(19, 9),
    TIER1CAPITALRATIOCORRECTAT DATE,
    LEVERAGERATIO              NUMBER(19, 9),
    LEVERAGERATIOCORRECTAT     DATE,
    CREDITRATINGAGENCY         VARCHAR2(50 char)
        constraint PBD_CREDITRATINGAGENCY_CC
            check (creditRatingAgency IN ('MOODYS', 'SANDP', 'FITCH')),
    CREDITRATING               VARCHAR2(4 char),
    CREDITRATINGCORRECTAT      DATE,
    INFONOTES                  CLOB,
    CREATEDBYUSERID            NUMBER(19)                          not null,
    CREATEDUTC                 TIMESTAMP(6)                        not null,
    LASTUPDATEDBYUSERID        NUMBER(19)                          not null,
    LASTUPDATEDUTC             TIMESTAMP(6)                        not null,
    BILLINGMETHOD              VARCHAR2(14 char)
        constraint PBD_BILLINGMETHOD_CC
            check (BILLINGMETHOD IN ('NONE', 'POST', 'EMAIL', 'EMAILANDPOST')),
    BILLINGADDRESSID           NUMBER(19)
        references BANKADDRESS,
    BILLINGCONTACTNAME         VARCHAR2(100 char),
    BILLINGEMAILADDRESS        VARCHAR2(100 char)
);

create index FK3_PARTNERBANKDETAILS
    on PARTNERBANKDETAILS (LOGO);

create index FK4_PARTNERBANKDETAILS
    on PARTNERBANKDETAILS (BILLINGADDRESSID);

create index FK2_PARTNERBANKDETAILS
    on PARTNERBANKDETAILS (PARTNERBANKID);

create index FK1_PARTNERBANKDETAILS
    on PARTNERBANKDETAILS (BANKADDRESSID);

create table PARTNERBANKFEESINVOICE
(
    PARTNERBANKFEESINVOICEID NUMBER(19)         not null
        constraint PK_PARTNERBANKFEESINVOICE
            primary key,
    PARTNERBANKID            NUMBER(19)         not null
        constraint PB_PBFI
            references PARTNERBANK,
    CREATEDBYUSERID          NUMBER(19)         not null
        constraint IU_PBFI
            references INTERNALUSER,
    FILEPUBLICID             VARCHAR2(22 char)  not null
        constraint AK1_PARTNERBANKFEESINVOICE
            unique,
    INVOICEID                VARCHAR2(30 char)  not null
        constraint AK2_PARTNERBANKFEESINVOICE
            unique,
    STARTDATE                DATE               not null,
    ENDDATE                  DATE               not null,
    TYPE                     VARCHAR2(18 char)  not null
        constraint PBFI_TYPE_CC
            check (type IN ('SERVICE_FEE', 'POOLED_ACCOUNT_FEE', 'OTHER')),
    STATUS                   VARCHAR2(10 char)  not null
        constraint PBFI_STATUS_CC
            check (status IN ('PENDING', 'PUBLISHED')),
    SOURCE                   VARCHAR2(7 char)   not null
        constraint PBFI_SOURCE_CC
            check (source IN ('MANUAL', 'SYSTEM')),
    PUBLISHEDUTC             TIMESTAMP(6),
    DATA                     BLOB               not null,
    FILENAME                 VARCHAR2(255 char) not null
);

create index FK1_PARTNERBANKFEESINVOICE
    on PARTNERBANKFEESINVOICE (PARTNERBANKID);

create index FK2_PARTNERBANKFEESINVOICE
    on PARTNERBANKFEESINVOICE (CREATEDBYUSERID);

create table PARTNERBANKHISTORY
(
    PARTNERBANKID          NUMBER(19),
    TRANSACTIONID          NUMBER(19) not null,
    BANKNAME               VARCHAR2(50 char),
    ENTITYTYPE             VARCHAR2(20 char),
    BIC                    VARCHAR2(11 char),
    FIRMREFERENCENUMBER    NUMBER(20),
    STATUS                 VARCHAR2(8 char),
    NOTES                  CLOB,
    BANKMESSAGINGPROFILEID NUMBER(19),
    PARTNERBANKSYNCMODELID NUMBER(19)
        constraint PBH_PBSM
            references PARTNERBANKSYNCMODEL,
    MT940SCHEDULEID        NUMBER(19)
        constraint FK_PBH_MT940
            references MT940SCHEDULE,
    MAXORDERSPERSYNC       NUMBER(19),
    PARTNERBANKPUBLICID    VARCHAR2(24 char)
);

create index FK1_PARTNERBANKHISTORY
    on PARTNERBANKHISTORY (PARTNERBANKSYNCMODELID);

create table PARTNERBANKMATURITYSETTINGS
(
    PARTNERBANKMATURITYSETTINGSID NUMBER(19) not null
        primary key,
    PARTNERBANKID                 NUMBER(19) not null
        constraint AK1_PARTNERBANKID
            unique
        constraint PB_PARTNERBANKMATURITYSETTINGS
            references PARTNERBANK,
    DAYCOUNT                      VARCHAR2(18 char),
    INTERESTSTARTOFFSET           NUMBER(10),
    INTERESTMATURITYOFFSET        NUMBER(10),
    MATURITYPAYMENTOFFSET         NUMBER(10),
    PAYMENTMETHOD                 VARCHAR2(20 char),
    SINGLEPAYMENT                 NUMBER(3),
    INTERESTPAYMENTANNIVERSARY    VARCHAR2(27 char),
    INTERESTPAYMENTTYPE           VARCHAR2(27 char),
    COMPOUNDINTERESTPAYMENTDATE   VARCHAR2(32 char)
        constraint PBMS_CIPD_CC
            check (compoundInterestPaymentDate IN (
                                                   'START_DATE_MONTHLY_ANNIVERSARY',
                                                   'START_DATE_ANNIVERSARY',
                                                   'FIRST_DAY_MONTHLY',
                                                   'LAST_DAY_MONTHLY'
                ))
);

create table PARTNERBANKPERMISSION
(
    PARTNERBANKPERMISSIONID      NUMBER(19)          not null
        primary key,
    PARTNERBANKID                NUMBER(19)          not null
        constraint PARTNERBANKPERMISSION_UNIQUE
            unique
        constraint PB_PARTNERBANKPERMISSION
            references PARTNERBANK,
    EASYACCESSISAPRODUCTSENABLED NUMBER(1)           not null,
    FIXEDTERMISAPRODUCTSENABLED  NUMBER(1)           not null,
    LIMITEDACCESSISAENABLED      NUMBER(1) default 0 not null,
    LIMITEDACCESSASENABLED       NUMBER(1) default 0 not null,
    FIXEDTERMROLLOVERENABLED     NUMBER(1) default 0 not null
);

create table PARTNERBANKUSER
(
    INTERNALUSERID NUMBER(19) not null
        constraint IU_PBU
            references INTERNALUSER,
    PARTNERBANKID  NUMBER(19) not null
        constraint PB_PBU
            references PARTNERBANK
);

create index FK1_PARTNERBANKUSER
    on PARTNERBANKUSER (PARTNERBANKID);

create unique index AK1_PARTNERBANKUSER
    on PARTNERBANKUSER (INTERNALUSERID);

create table PAYMENTHISTORY
(
    PAYMENTID         NUMBER(19),
    TRANSACTIONID     NUMBER(19),
    EXTERNALREFERENCE VARCHAR2(35 char),
    PAYMENTTYPE       VARCHAR2(5 char),
    STATUS            VARCHAR2(5 char),
    AMOUNT            NUMBER(19, 2),
    CREATEDUTC        TIMESTAMP(6),
    MANUAL            NUMBER(3) default 0,
    SRCCASHMOVEMENTID NUMBER(19),
    DSTCASHMOVEMENTID NUMBER(19),
    SOURCE            VARCHAR2(100 char),
    SRCACCTIDENTIFIER VARCHAR2(50 char),
    DESTINATION       VARCHAR2(100 char),
    DSTACCTIDENTIFIER VARCHAR2(50 char)
);

create table PERMISSION
(
    PERMISSIONID   NUMBER(19)        not null
        primary key,
    PERMISSIONNAME VARCHAR2(50 char) not null
);

create unique index AK1_PERMISSION
    on PERMISSION (PERMISSIONNAME);

create table PRINCIPALORDERHISTORY
(
    PRINCIPALORDERID NUMBER(19)        not null,
    TRANSACTIONID    NUMBER(19)        not null,
    CASHACCOUNTID    NUMBER(19)        not null,
    INSTRUMENTID     NUMBER(19)        not null,
    STATUS           VARCHAR2(20 char) not null,
    UPDATEDUTC       TIMESTAMP(6)      not null,
    GENERICORDERID   NUMBER(19)
);

create table PRODUCT
(
    PRODUCTID   NUMBER(19)        not null
        primary key,
    PRODUCTNAME VARCHAR2(55 char) not null,
    PRODUCTTYPE VARCHAR2(24 char) not null
        constraint UNIQUE_PRODUCTTYPE
            unique
        constraint P_PRODUCTTYPE_CC
            check (productType IN ('FIXED_TERM_FIXED_DATES', 'FIXED_TERM_ROLLING_DATES', 'EASY_ACCESS', 'CASH_RESERVE'))
);

create table INSTRUMENTTEMPLATE
(
    INSTRUMENTTEMPLATEID NUMBER(19)                 not null
        primary key,
    PARTNERBANKID        NUMBER(19)                 not null
        constraint PB_INSTEMP
            references PARTNERBANK,
    CREATEDBYUSERID      NUMBER(19)                 not null
        constraint IU_INSTEMP
            references INTERNALUSER,
    TEMPLATENAME         VARCHAR2(50 char)          not null,
    LENGTHOFTERM         NUMBER(10)                 not null,
    INTERESTTYPE         VARCHAR2(5 char)           not null
        check (INTERESTTYPE IN ('FIXED')),
    INTERESTFREQUENCY    VARCHAR2(9 char)
        check (INTERESTFREQUENCY IN ('MATURITY', 'ANNUALLY')),
    CURRENCYCODE         VARCHAR2(3 char) default 'GBP'
        check (CURRENCYCODE in ('GBP')),
    MINIMUMBALANCE       NUMBER(19, 2)              not null,
    MAXIMUMBALANCE       NUMBER(19, 2)              not null,
    COOLINGOFFPERIOD     NUMBER(10),
    CREATEDUTC           TIMESTAMP(6)               not null,
    PRODUCTID            NUMBER(19)                 not null
        constraint P_INSTEMP
            references PRODUCT,
    TEMPLATEVERSION      NUMBER(19)       default 1 not null,
    COMPOUNDINGINTEREST  NUMBER(3)        default 0 not null,
    PRIVATEOFFERING      NUMBER(1)        default 0 not null,
    constraint AK1_INSTRUMENTTEMPLATE
        unique (TEMPLATENAME, PARTNERBANKID)
);

comment on column INSTRUMENTTEMPLATE.COOLINGOFFPERIOD is 'Number of days for the cooling off period. Note that 0 denotes no cooling off period support';

create table PRODUCTFEE
(
    PRODUCTFEEID NUMBER(19)     not null
        constraint PK_PRODUCTFEE
            primary key,
    RATE         NUMBER(19, 10) not null,
    EFFECTIVEUTC TIMESTAMP(6)   not null,
    CREATEDUTC   TIMESTAMP(6)   not null
);

create table QRTZ_CALENDARS
(
    SCHED_NAME    VARCHAR2(120 char) not null,
    CALENDAR_NAME VARCHAR2(200 char) not null,
    CALENDAR      BLOB               not null,
    constraint QRTZ_CALENDARS_PK
        primary key (SCHED_NAME, CALENDAR_NAME)
);

create table QRTZ_FIRED_TRIGGERS
(
    SCHED_NAME        VARCHAR2(120 char) not null,
    ENTRY_ID          VARCHAR2(95 char)  not null,
    TRIGGER_NAME      VARCHAR2(200 char) not null,
    TRIGGER_GROUP     VARCHAR2(200 char) not null,
    INSTANCE_NAME     VARCHAR2(200 char) not null,
    FIRED_TIME        NUMBER(13)         not null,
    SCHED_TIME        NUMBER(13)         not null,
    PRIORITY          NUMBER(13)         not null,
    STATE             VARCHAR2(16 char)  not null,
    JOB_NAME          VARCHAR2(200 char),
    JOB_GROUP         VARCHAR2(200 char),
    IS_NONCONCURRENT  VARCHAR2(1 char),
    REQUESTS_RECOVERY VARCHAR2(1 char),
    constraint QRTZ_FIRED_TRIGGER_PK
        primary key (SCHED_NAME, ENTRY_ID)
);

create index IDX_QRTZ_FT_JG
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_FT_J_G
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);

create index IDX_QRTZ_FT_T_G
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

create index IDX_QRTZ_FT_TRIG_INST_NAME
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME);

create index IDX_QRTZ_FT_INST_JOB_REQ_RCVRY
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY);

create index IDX_QRTZ_FT_TG
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);

create table QRTZ_JOB_DETAILS
(
    SCHED_NAME        VARCHAR2(120 char) not null,
    JOB_NAME          VARCHAR2(200 char) not null,
    JOB_GROUP         VARCHAR2(200 char) not null,
    DESCRIPTION       VARCHAR2(250 char),
    JOB_CLASS_NAME    VARCHAR2(250 char) not null,
    IS_DURABLE        VARCHAR2(1 char)   not null,
    IS_NONCONCURRENT  VARCHAR2(1 char)   not null,
    IS_UPDATE_DATA    VARCHAR2(1 char)   not null,
    REQUESTS_RECOVERY VARCHAR2(1 char)   not null,
    JOB_DATA          BLOB,
    constraint QRTZ_JOB_DETAILS_PK
        primary key (SCHED_NAME, JOB_NAME, JOB_GROUP)
);

create index IDX_QRTZ_J_GRP
    on QRTZ_JOB_DETAILS (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_J_REQ_RECOVERY
    on QRTZ_JOB_DETAILS (SCHED_NAME, REQUESTS_RECOVERY);

create table QRTZ_LOCKS
(
    SCHED_NAME VARCHAR2(120 char) not null,
    LOCK_NAME  VARCHAR2(40 char)  not null,
    constraint QRTZ_LOCKS_PK
        primary key (SCHED_NAME, LOCK_NAME)
);

create table QRTZ_PAUSED_TRIGGER_GRPS
(
    SCHED_NAME    VARCHAR2(120 char) not null,
    TRIGGER_GROUP VARCHAR2(200 char) not null,
    constraint QRTZ_PAUSED_TRIG_GRPS_PK
        primary key (SCHED_NAME, TRIGGER_GROUP)
);

create table QRTZ_SCHEDULER_STATE
(
    SCHED_NAME        VARCHAR2(120 char) not null,
    INSTANCE_NAME     VARCHAR2(200 char) not null,
    LAST_CHECKIN_TIME NUMBER(13)         not null,
    CHECKIN_INTERVAL  NUMBER(13)         not null,
    constraint QRTZ_SCHEDULER_STATE_PK
        primary key (SCHED_NAME, INSTANCE_NAME)
);

create table QRTZ_TRIGGERS
(
    SCHED_NAME     VARCHAR2(120 char) not null,
    TRIGGER_NAME   VARCHAR2(200 char) not null,
    TRIGGER_GROUP  VARCHAR2(200 char) not null,
    JOB_NAME       VARCHAR2(200 char) not null,
    JOB_GROUP      VARCHAR2(200 char) not null,
    DESCRIPTION    VARCHAR2(250 char),
    NEXT_FIRE_TIME NUMBER(13),
    PREV_FIRE_TIME NUMBER(13),
    PRIORITY       NUMBER(13),
    TRIGGER_STATE  VARCHAR2(16 char)  not null,
    TRIGGER_TYPE   VARCHAR2(8 char)   not null,
    START_TIME     NUMBER(13)         not null,
    END_TIME       NUMBER(13),
    CALENDAR_NAME  VARCHAR2(200 char),
    MISFIRE_INSTR  NUMBER(2),
    JOB_DATA       BLOB,
    constraint QRTZ_TRIGGER_TO_JOBS_FK
        foreign key (SCHED_NAME, JOB_NAME, JOB_GROUP) references QRTZ_JOB_DETAILS
);

create index IDX_QRTZ_T_NFT_MISFIRE
    on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_NFT_ST_MISFIRE_GRP
    on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_NFT_ST_MISFIRE
    on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_STATE);

create index IDX_QRTZ_T_NEXT_FIRE_TIME
    on QRTZ_TRIGGERS (SCHED_NAME, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_N_STATE
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_J
    on QRTZ_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);

create index IDX_QRTZ_T_STATE
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE);

create unique index QRTZ_TRIGGERS_PK
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

create index IDX_QRTZ_T_N_G_STATE
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_C
    on QRTZ_TRIGGERS (SCHED_NAME, CALENDAR_NAME);

create index IDX_QRTZ_T_NFT_ST
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_G
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);

create index IDX_QRTZ_T_JG
    on QRTZ_TRIGGERS (SCHED_NAME, JOB_GROUP);

alter table QRTZ_TRIGGERS
    add constraint QRTZ_TRIGGERS_PK
        primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE);

create table QRTZ_BLOB_TRIGGERS
(
    SCHED_NAME    VARCHAR2(120 char) not null,
    TRIGGER_NAME  VARCHAR2(200 char) not null,
    TRIGGER_GROUP VARCHAR2(200 char) not null,
    BLOB_DATA     BLOB,
    constraint QRTZ_BLOB_TRIG_PK
        primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_BLOB_TRIG_TO_TRIG_FK
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS
);

create table QRTZ_CRON_TRIGGERS
(
    SCHED_NAME      VARCHAR2(120 char) not null,
    TRIGGER_NAME    VARCHAR2(200 char) not null,
    TRIGGER_GROUP   VARCHAR2(200 char) not null,
    CRON_EXPRESSION VARCHAR2(120 char) not null,
    TIME_ZONE_ID    VARCHAR2(80 char),
    constraint QRTZ_CRON_TRIG_PK
        primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_CRON_TRIG_TO_TRIG_FK
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS
);

create table QRTZ_SIMPLE_TRIGGERS
(
    SCHED_NAME      VARCHAR2(120 char) not null,
    TRIGGER_NAME    VARCHAR2(200 char) not null,
    TRIGGER_GROUP   VARCHAR2(200 char) not null,
    REPEAT_COUNT    NUMBER(7)          not null,
    REPEAT_INTERVAL NUMBER(12)         not null,
    TIMES_TRIGGERED NUMBER(10)         not null,
    constraint QRTZ_SIMPLE_TRIG_PK
        primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_SIMPLE_TRIG_TO_TRIG_FK
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS
);

create table QRTZ_SIMPROP_TRIGGERS
(
    SCHED_NAME    VARCHAR2(120 char) not null,
    TRIGGER_NAME  VARCHAR2(200 char) not null,
    TRIGGER_GROUP VARCHAR2(200 char) not null,
    STR_PROP_1    VARCHAR2(512 char),
    STR_PROP_2    VARCHAR2(512 char),
    STR_PROP_3    VARCHAR2(512 char),
    INT_PROP_1    NUMBER(10),
    INT_PROP_2    NUMBER(10),
    LONG_PROP_1   NUMBER(13),
    LONG_PROP_2   NUMBER(13),
    DEC_PROP_1    NUMBER(13, 4),
    DEC_PROP_2    NUMBER(13, 4),
    BOOL_PROP_1   VARCHAR2(1 char),
    BOOL_PROP_2   VARCHAR2(1 char),
    constraint QRTZ_SIMPROP_TRIG_PK
        primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_SIMPROP_TRIG_TO_TRIG_FK
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS
);

create table REPORTFILE
(
    REPORTFILEID  NUMBER(19)         not null
        primary key,
    PARTNERBANKID NUMBER(19),
    FILENAME      VARCHAR2(255 char) not null,
    DATA          BLOB               not null,
    CREATEDUTC    TIMESTAMP(6)       not null,
    BANKACCOUNTID NUMBER(19),
    constraint BA_RF_NOT_BOTH_NULL
        check (PartnerBankId IS NOT NULL AND BankAccountId IS NULL OR
               BankAccountId IS NOT NULL AND PartnerBankId IS NULL)
);

create index FK2_REPORTFILE
    on REPORTFILE (PARTNERBANKID);

create index FK1_REPORTFILE
    on REPORTFILE (BANKACCOUNTID);

create table ROLE
(
    ROLEID     NUMBER(19)        not null
        primary key,
    ROLENAME   VARCHAR2(50 char) not null,
    RESTRICTED NUMBER(3)         not null
        constraint R_RESTRICTED_CC
            check (restricted IN (0, 1))
);

create unique index AK1_ROLE
    on ROLE (ROLENAME);

create table ROLEPERMISSION
(
    ROLEID       NUMBER(19) not null
        constraint R_RA
            references ROLE,
    PERMISSIONID NUMBER(19) not null
        constraint A_RA
            references PERMISSION,
    primary key (ROLEID, PERMISSIONID)
);

create index FK1_ROLEPERMISSION
    on ROLEPERMISSION (ROLEID);

create index FK2_ROLEPERMISSION
    on ROLEPERMISSION (PERMISSIONID);

create table SECURITYQUESTION
(
    SECURITYQUESTIONID NUMBER(19)         not null
        primary key,
    QUESTION           VARCHAR2(255 char) not null
);

create table SERVICELEVELAGREEMENT
(
    SERVICELEVELAGREEMENTID NUMBER(19)        not null
        primary key,
    PARTNERBANKID           NUMBER(19)
        constraint SLA_PB
            references PARTNERBANK,
    SLATIME                 TIMESTAMP(6)      not null,
    SLATYPE                 VARCHAR2(50 char) not null
        constraint SLA_TIME_TYPE
            check (slaType IN ('PAYMENTS_TO_PB', 'PAYMENTS_FROM_PB', 'EOD_CONFIRMATION', 'WITHDRAWAL_ORDER_CUTOFF')),
    CREATEDUTC              TIMESTAMP(6)      not null
);

create table SLAHISTORY
(
    SERVICELEVELAGREEMENTID NUMBER(19),
    TRANSACTIONID           NUMBER(19) not null,
    PARTNERBANKID           NUMBER(19),
    SLATIME                 TIMESTAMP(6),
    SLATYPE                 VARCHAR2(50 char),
    CREATEDUTC              TIMESTAMP(6)
);

create table SUBSCRIPTION
(
    SUBSCRIPTIONID NUMBER(19)                   not null
        primary key,
    GENERICORDERID NUMBER(19)                   not null
        constraint ORD_SUB
            references GENERICORDER,
    AMOUNT         NUMBER(19, 2)                not null,
    MARK           VARCHAR2(2 char) default 'C' not null
        constraint SUB_MARK_CC
            check (mark IN ('D', 'C', 'RC', 'RD')),
    TYPE           VARCHAR2(12 char)            not null,
    STATUS         VARCHAR2(15 char)            not null
        constraint SUB_STATUS_CC
            check (status IN ('PENDING', 'COMPLETED', 'CANCELLED', 'TRANSFERRED_OUT', 'VOIDED', 'COOLED_OFF'))
);

create table SUBSCRIPTIONHISTORY
(
    SUBSCRIPTIONID NUMBER(19)        not null,
    TRANSACTIONID  NUMBER(19)        not null,
    GENERICORDERID NUMBER(19)        not null,
    AMOUNT         NUMBER(19, 2)     not null,
    MARK           VARCHAR2(2 char)  not null,
    TYPE           VARCHAR2(12 char) not null,
    STATUS         VARCHAR2(15 char) not null
);

create table SWEEPERPROCESSHISTORY
(
    SWEEPERPROCESSID NUMBER(19)        not null,
    TRANSACTIONID    NUMBER(19)        not null,
    STATUS           VARCHAR2(30 char) not null,
    CREATEDUTC       TIMESTAMP(6),
    CASHMOVEMENTID   NUMBER(19)        not null
);

create table TRANSFERORDERHISTORY
(
    TRANSACTIONID         NUMBER(19)                   not null,
    TRANSFERORDERID       NUMBER(19),
    CASHACCOUNTID         NUMBER(19),
    HLPRODUCTID           NUMBER(19),
    STATUS                VARCHAR2(9 char),
    REQUESTEDUTC          TIMESTAMP(6),
    MSGREFERENCE          VARCHAR2(36 char),
    EXPECTEDBYUTC         TIMESTAMP(6)                 not null,
    CUSTOMERID            NUMBER(19),
    FROMCUSTOMERID        NUMBER(19),
    TOCUSTOMERID          NUMBER(19),
    ACTIONONBEHALFSOURCE  VARCHAR2(20 char),
    GENERICORDERID        NUMBER(19),
    MARK                  VARCHAR2(1 char) default 'D' not null
        check (Mark in ('D', 'C')),
    LINKEDTRANSFERORDERID NUMBER(19)
);

create table TREASURYBLOCKHISTORY
(
    TREASURYBLOCKID NUMBER(19),
    TRANSACTIONID   NUMBER(19) not null,
    INSTRUMENTID    NUMBER(19),
    BLOCKREFERENCE  VARCHAR2(16 char),
    COMMONREFERENCE VARCHAR2(16 char),
    TRADEREFERENCE  VARCHAR2(50 char)
);

create table TREASURYBLOCKINTERESTHISTORY
(
    TREASURYBLOCKINTERESTID NUMBER(19)    not null,
    TREASURYBLOCKID         NUMBER(19)    not null,
    UPDATEDBYID             NUMBER(19),
    VALUEDATE               DATE          not null,
    POSTEDUTC               TIMESTAMP(6),
    AMOUNT                  NUMBER(19, 2) not null,
    CREATEDBYID             NUMBER(19)    not null,
    CREATEDUTC              TIMESTAMP(6)  not null,
    TRANSACTIONID           NUMBER(19)    not null,
    REJECTEDUTC             TIMESTAMP(6)
);

create table TREASURYBLOCKSTATEMENT
(
    TREASURYBLOCKSTATEMENTID NUMBER(19)   not null
        constraint PK_TREASURYBLOCKSTATEMENT
            primary key,
    STATEMENTDATE            DATE         not null,
    STATUS                   VARCHAR2(10 char)
        constraint TBS_STATUS_CC
            check (STATUS IN ('DRAFT', 'COMPLETED')),
    CREATEDUTC               TIMESTAMP(6) not null,
    UPDATEDUTC               TIMESTAMP(6) not null,
    PARTNERBANKID            NUMBER(19)   not null
        constraint FKTREASURYBL745338
            references PARTNERBANK
);

create index FK1_TREASURYBLOCKSTATEMENT
    on TREASURYBLOCKSTATEMENT (PARTNERBANKID);

create table TREASURYOPHISTORY
(
    TREASURYOPERATIONID      NUMBER(19),
    TRANSACTIONID            NUMBER(19) not null,
    TREASURYBLOCKID          NUMBER(19),
    SYNCHRONIZATIONPROCESSID NUMBER(19),
    SENDERREFERENCE          VARCHAR2(16 char),
    CONFIRMED                NUMBER(3),
    ACTION                   VARCHAR2(4 char),
    TYPE                     VARCHAR2(4 char),
    PARTYA                   VARCHAR2(11 char),
    PARTYB                   VARCHAR2(11 char),
    PRINCIPAL                NUMBER(19, 2),
    RATE                     NUMBER(19, 10),
    INTEREST                 NUMBER(19, 2),
    CURRENCY                 VARCHAR2(3 char),
    MATURITYDATE             DATE,
    VALUEDATE                DATE,
    TRADEDATE                DATE,
    CREATEDUTC               TIMESTAMP(6),
    NEXTINTERESTDUEDATE      DATE,
    SOURCE                   VARCHAR2(15 char),
    TREASURYBLOCKINTERESTID  NUMBER(19)
);

create table USERACTIONS
(
    INTERNALUSERID          NUMBER(19) not null
        primary key
        constraint IU_UA
            references INTERNALUSER,
    CREATESECURITYQUESTIONS NUMBER(3)  not null
        constraint UA_CREATESECURITYQ_CC
            check (createSecurityQuestions IN (0, 1)),
    PASSWORDRESET           NUMBER(3)  not null
        constraint UA_PASSWORDRESET_CC
            check (passwordReset IN (0, 1))
);

create table USERAUTHENTICATIONSTATUS
(
    INTERNALUSERID          NUMBER(19)           not null
        primary key
        constraint IU_UAS
            references INTERNALUSER,
    CONSECUTIVEFAILURECOUNT NUMBER(19) default 0 not null,
    LASTFAILUREUTC          TIMESTAMP(6)
);

create table USERPASSWORD
(
    USERPASSWORDID NUMBER(19)         not null
        primary key,
    INTERNALUSERID NUMBER(19)         not null
        constraint IU_UP
            references INTERNALUSER,
    HASHEDPASSWORD VARCHAR2(255 char) not null,
    SALT           VARCHAR2(255 char) not null,
    ITERATIONCOUNT NUMBER(10)         not null,
    CREATEDUTC     TIMESTAMP(6)       not null,
    EXPIRED        NUMBER(3)          not null
        constraint UP_EXPIRED_CC
            check (expired IN (0, 1))
);

create index FK1_USERPASSWORD
    on USERPASSWORD (INTERNALUSERID);

create table USERPASSWORDHISTORY
(
    USERPASSWORDID NUMBER(19)         not null,
    TRANSACTIONID  NUMBER(19)         not null,
    INTERNALUSERID NUMBER(19)         not null,
    HASHEDPASSWORD VARCHAR2(255 char) not null,
    SALT           VARCHAR2(255 char) not null,
    ITERATIONCOUNT NUMBER(10)         not null,
    CREATEDUTC     TIMESTAMP(6)       not null,
    EXPIRED        NUMBER(3)          not null
);

create table USERROLE
(
    INTERNALUSERID NUMBER(19) not null
        constraint IU_UR
            references INTERNALUSER,
    ROLEID         NUMBER(19) not null
        constraint R_UR
            references ROLE,
    primary key (INTERNALUSERID, ROLEID)
);

create index FK2_USERROLE
    on USERROLE (ROLEID);

create index FK1_USERROLE
    on USERROLE (INTERNALUSERID);

create table USERSECURITYANSWER
(
    USERSECURITYANSWERID NUMBER(19) not null
        primary key,
    INTERNALUSERID       NUMBER(19) not null
        constraint IU_USA
            references INTERNALUSER,
    SECURITYQUESTIONID   NUMBER(19) not null
        constraint SQ_USA
            references SECURITYQUESTION,
    ENCRYPTEDANSWER      RAW(250)   not null,
    INITVECTOR           RAW(30)    not null
);

create index FK2_USERSECURITYANSWER
    on USERSECURITYANSWER (SECURITYQUESTIONID);

create index FK1_USERSECURITYANSWER
    on USERSECURITYANSWER (INTERNALUSERID);

create table HLPRODUCT
(
    HLPRODUCTID      NUMBER(19)        not null
        primary key,
    CODE             VARCHAR2(2 char)  not null,
    DESCRIPTION      VARCHAR2(50 char) not null,
    HLPRODUCTLIMITID NUMBER(19)
        constraint HLPL_VP
            references HLPRODUCTLIMIT
);

create table CRONSCHEDULE
(
    CRONSCHEDULEID   NUMBER(19)         not null
        primary key,
    PARTNERBANKID    NUMBER(19)
        constraint CS_PB
            references PARTNERBANK,
    CRONSCHEDULETYPE VARCHAR2(50 char)  not null,
    CRONSETTINGS     VARCHAR2(100 char) not null,
    HLPRODUCTID      NUMBER(19)
        constraint CS_VP_VANTAGEPRODUCT
            references HLPRODUCT
);

create table INSTRUMENT
(
    INSTRUMENTID           NUMBER(19)          not null
        primary key,
    PARTNERBANKID          NUMBER(19)          not null
        constraint PB_INS
            references PARTNERBANK,
    PRODUCTID              NUMBER(19)          not null
        constraint P_INS
            references PRODUCT,
    EXTERNALREFERENCE      VARCHAR2(35 char)   not null,
    TESTPRODUCT            NUMBER(3) default 0 not null
        check (testProduct in (0, 1)),
    FROMTEMPLATE           NUMBER(3) default 0
        check (fromTemplate in (0, 1)),
    TEMPLATENAME           VARCHAR2(50 char),
    TEMPLATEVERSION        NUMBER(19),
    PRIVATEOFFERING        NUMBER(3) default 0 not null,
    HLPRODUCTID            NUMBER(19)          not null
        constraint VP_INS
            references HLPRODUCT,
    PARENTINSTRUMENTID     NUMBER(19),
    INVISIBLEINLATESTRATES NUMBER(3) default 0
        constraint INVISBLEINLATESTRATES
            check (InvisibleInLatestRates IN (0, 1)),
    constraint AK1_INSTRUMENT
        unique (EXTERNALREFERENCE, PARTNERBANKID)
);

create table FUNDINGORDER
(
    FUNDINGORDERID NUMBER(19)        not null
        constraint PK_FUNDINGORDER
            primary key,
    INSTRUMENTID   NUMBER(19)        not null
        constraint FO_I
            references INSTRUMENT,
    MARKATPOOLED   VARCHAR2(2 char)  not null,
    STATUS         VARCHAR2(22 char) not null
        constraint FUNDORD_STATUS_CC
            check (status IN ('PENDING', 'AWAITING_CONFIRMATION', 'COMPLETED', 'CANCELLED')),
    UPDATEDUTC     TIMESTAMP(6)      not null,
    GENERICORDERID NUMBER(19)        not null
        constraint ORD_FUNDORD
            references GENERICORDER
);

create index FK1_FUNDINGORDER
    on FUNDINGORDER (INSTRUMENTID);

create unique index FK2_FUNDINGORDER
    on FUNDINGORDER (GENERICORDERID);

create index FK3_INSTRUMENT
    on INSTRUMENT (HLPRODUCTID);

create index FK2_INSTRUMENT
    on INSTRUMENT (PRODUCTID);

create index FK1_INSTRUMENT
    on INSTRUMENT (PARTNERBANKID);

create table INSTRUMENTDETAIL
(
    INSTRUMENTDETAILID          NUMBER(19)                 not null
        primary key,
    INSTRUMENTID                NUMBER(19)                 not null
        constraint INS_ID
            references INSTRUMENT,
    INSTRUMENTNAME              VARCHAR2(200 char)         not null,
    DESCRIPTION                 CLOB,
    STATUS                      VARCHAR2(36 char)          not null
        constraint ID_STATUS_CC
            check (status IN (
                              'PENDING',
                              'PENDING_REVIEW_BY_SECOND_USER',
                              'REJECTED_BY_SECOND_USER',
                              'DELETED_BEFORE_PUBLICATION',
                              'SUBMITTED_TO_HL_FOR_REVIEW',
                              'PENDING_SECOND_HL_REVIEW',
                              'REJECTED_BY_HL',
                              'COMPLETED',
                              'EXPIRED',
                              'CANCELLED',
                              'TEMPLATE_SUBMISSION_PENDING',
                              'TEMPLATE_SUBMISSION_CANCELLED',
                              'ROLLOVER_SUBMISSION_PENDING',
                              'ROLLOVER_SUBMISSION_CANCELLED')),
    LENGTHOFTERM                NUMBER(10),
    AER                         NUMBER(19, 10),
    GROSSRATE                   NUMBER(19, 10),
    INTERESTTYPE                VARCHAR2(10 char)          not null
        constraint ID_INTERESTTYPE_CC
            check (interesttype IN ('FIXED', 'VARIABLE')),
    INTERESTFREQUENCY           VARCHAR2(9 char)
        constraint ID_INTERESTFREQUENCY_CC
            check (interestFrequency IN ('MONTHLY', 'QUARTERLY', 'ANNUALLY', 'MATURITY')),
    CURRENCYCODE                VARCHAR2(3 char) default 'GBP'
        constraint ID_CURRENCYCODE_CC
            check (currencyCode in ('GBP')),
    MINIMUMINVESTMENT           NUMBER(19, 2),
    MAXIMUMINVESTMENT           NUMBER(19, 2),
    MINIMUMBALANCE              NUMBER(19, 2),
    MAXIMUMBALANCE              NUMBER(19, 2),
    CANWITHDRAW                 NUMBER(3)
        constraint ID_CANWITHDRAW_CC
            check (canWithdraw in (0, 1)),
    WITHDRAWALFEE               NUMBER(10),
    MATURITYELIGIBLE            NUMBER(3)
        constraint ID_MATURITYELIGIBLE_CC
            check (maturityEligible in (0, 1)),
    COOLINGOFFPERIOD            NUMBER(10),
    COOLINGOFFTOPUP             NUMBER(3)
        constraint ID_TOPUPALLOWED_CC
            check ("COOLINGOFFTOPUP" = 0 OR "COOLINGOFFTOPUP" = 1),
    FROMDATEUTC                 TIMESTAMP(6),
    TODATEUTC                   TIMESTAMP(6),
    INVESTMENTSTARTDATEUTC      TIMESTAMP(6),
    INVESTMENTENDDATEUTC        TIMESTAMP(6),
    OPENSETTLEMENTPERIOD        VARCHAR2(9 char)
        constraint ID_OPENSETTLEMENTPERIOD_CC
            check (openSettlementPeriod IN ('INTRA_DAY', 'TPLUS1', 'TPLUS2', 'TPLUS3', 'TPLUS4', 'TPLUS5', 'TPLUS6')),
    CLOSESETTLEMENTPERIOD       VARCHAR2(9 char)
        constraint ID_CLOSESETTLEMENTPERIOD_CC
            check (closeSettlementPeriod IN ('INTRA_DAY', 'TPLUS1', 'TPLUS2', 'TPLUS3', 'TPLUS4', 'TPLUS5', 'TPLUS6')),
    FUNDINGCAP                  NUMBER(19, 2),
    ACTIONDATEUTC               TIMESTAMP(6),
    ACTIONREASON                CLOB,
    MINIMUMWITHDRAWAL           NUMBER(19, 2),
    MAXIMUMWITHDRAWAL           NUMBER(19, 2),
    CREATEDBYUSERID             NUMBER(19)                 not null
        constraint IU_IDET
            references INTERNALUSER
                on delete cascade,
    CREATEDUTC                  TIMESTAMP(6)               not null,
    LASTUPDATEDBYUSERID         NUMBER(19)                 not null,
    LASTUPDATEDUTC              TIMESTAMP(6)               not null,
    EFFECTIVEDATEUTC            TIMESTAMP(6),
    COOLINGOFFPARTIALWITHDRAWAL NUMBER(3)        default 0
        constraint ID_COOLOFFPARTIALWITHDRAWAL_CC
            check (coolingOffPartialWithdrawal IN (0, 1)),
    PARTNERBANKINTERESTRATE     NUMBER(19, 10),
    COMPOUNDINGINTEREST         NUMBER(3)        default 0 not null,
    TOPUPRESTRICTED             NUMBER(3)        default 0 not null
        constraint TOPUPRESTRICTEDVALUES
            check (topupRestricted IN (0, 1)),
    PENALTYFREEWITHDRAWALS      NUMBER(10),
    PENALTYDAYS                 NUMBER(10),
    BONUSRATE                   NUMBER(19, 10),
    BONUSRATEENDDATE            DATE
);

create index FK1_INSTRUMENTDETAIL
    on INSTRUMENTDETAIL (INSTRUMENTID);

create index FK2_INSTRUMENTDETAIL
    on INSTRUMENTDETAIL (CREATEDBYUSERID);

create table INSTRUMENTDETAIL2FILEUPLOAD
(
    INSTRUMENTDETAILID NUMBER(19) not null
        constraint ID_ID2FU
            references INSTRUMENTDETAIL,
    FILEUPLOADID       NUMBER(19) not null
        constraint FU_ID2FU
            references FILEUPLOAD,
    primary key (INSTRUMENTDETAILID, FILEUPLOADID)
);

create index FK1_INSTRUMENTDET2FILEUPLOAD
    on INSTRUMENTDETAIL2FILEUPLOAD (INSTRUMENTDETAILID);

create index FK2_INSTRUMENTDET2FILEUPLOAD
    on INSTRUMENTDETAIL2FILEUPLOAD (FILEUPLOADID);

create table INSTRUMENTFEE
(
    INSTRUMENTFEEID NUMBER(19)     not null
        primary key,
    INSTRUMENTID    NUMBER(19)     not null
        references INSTRUMENT,
    RATE            NUMBER(19, 10) not null,
    EFFECTIVEUTC    TIMESTAMP(6)   not null,
    CREATEDUTC      TIMESTAMP(6)   not null
);

create table PARTNERBANKFEES
(
    PARTNERBANKFEESID  NUMBER(19)     not null
        constraint PK_PARTNERBANKFEES
            primary key,
    PARTNERBANKID      NUMBER(19)     not null
        constraint PBF_PB
            references PARTNERBANK,
    INSTRUMENTID       NUMBER(19)     not null
        constraint PBF_I
            references INSTRUMENT,
    CALCULATEDUTC      TIMESTAMP(6)   not null,
    FEECHARGE          NUMBER(19, 10) not null,
    CLOSINGBALANCE     NUMBER(19, 2)  not null,
    CALCULATEDDAILYFEE NUMBER(19, 10) not null,
    FEEDATE            DATE           not null,
    constraint PBF_U
        unique (INSTRUMENTID, FEEDATE)
);

create table SYNCHRONIZATIONPROCESS
(
    SYNCHRONIZATIONPROCESSID NUMBER(19)           not null
        primary key,
    PARTNERBANKID            NUMBER(19)           not null
        constraint FKSYNCHRONIZ118832
            references PARTNERBANK,
    STATUS                   VARCHAR2(30 char)    not null,
    STARTEDUTC               TIMESTAMP(6)         not null,
    COMPLETEDUTC             TIMESTAMP(6),
    ORDERALLOCATIONS         NUMBER(30, 16),
    CREDITALLOCATIONS        NUMBER(30, 16),
    DEBITALLOCATIONS         NUMBER(30, 16),
    INSTRUMENTCOUNT          NUMBER(30),
    ORDERCOUNT               NUMBER(30),
    MANUALPROFILE            NUMBER(3)  default 0 not null
        constraint SP_CV_MANPROF
            check (manualProfile IN (0, 1)),
    ACCOUNTOPENINGCOUNT      NUMBER(30) default 0 not null,
    FAILURECODE              VARCHAR2(20 char),
    FAILUREINFO              VARCHAR2(100 char),
    HLPRODUCTID              NUMBER(19)           not null
        constraint VP_SP
            references HLPRODUCT
);

create index FK1_SYNCHRONIZATIONPROCESS
    on SYNCHRONIZATIONPROCESS (PARTNERBANKID);

create table SYNCPROCESS2INSTRUMENT
(
    SYNCHRONIZATIONPROCESSID NUMBER(19) not null
        constraint SP_SP2INS
            references SYNCHRONIZATIONPROCESS,
    INSTRUMENTID             NUMBER(19) not null
        constraint INS_SP2INS
            references INSTRUMENT
);

create index FK2_SYNCPROCESS2INSTRUMENT
    on SYNCPROCESS2INSTRUMENT (INSTRUMENTID);

create index FK1_SYNCPROCESS2INSTRUMENT
    on SYNCPROCESS2INSTRUMENT (SYNCHRONIZATIONPROCESSID);

create table TREASURYBLOCK
(
    TREASURYBLOCKID NUMBER(19)        not null
        primary key,
    INSTRUMENTID    NUMBER(19)        not null
        constraint INS_TB
            references INSTRUMENT,
    BLOCKREFERENCE  VARCHAR2(16 char) not null,
    COMMONREFERENCE VARCHAR2(16 char) not null,
    TRADEREFERENCE  VARCHAR2(50 char)
);

create table BANKACCOUNT
(
    BANKACCOUNTID     NUMBER(19)          not null
        primary key,
    PARTNERBANKID     NUMBER(19)
        constraint PB_BA
            references PARTNERBANK,
    CHECKED           NUMBER(3)           not null
        constraint BA_CHECKED_CC
            check (checked IN (0, 1)),
    ACCOUNTTYPE       VARCHAR2(10 char)   not null
        constraint BA_ACCOUNTTYPE_CC
            check (accounttype IN ('CUST_V1', 'TB_V2', 'HUB', 'POOLED', 'SETTLEMENT', 'HLAM', 'FEES', 'CONTROL')),
    ACCOUNTNAME       VARCHAR2(50 char),
    PROCESSID         VARCHAR2(35 char),
    BANKREFERENCE     VARCHAR2(35 char),
    BANKNAME          VARCHAR2(50 char),
    BRANCHADDRESS     VARCHAR2(100 char),
    BRANCHPOSTCODE    VARCHAR2(8 char),
    BRANCHCITY        VARCHAR2(50 char),
    BRANCHPHONE       VARCHAR2(15 char),
    BRANCHEMAIL       VARCHAR2(255 char),
    CREATEDUTC        TIMESTAMP(6)        not null,
    TREASURYBLOCKID   NUMBER(19)
        constraint TB_BA
            references TREASURYBLOCK,
    ACCOUNTIDENTIFIER VARCHAR2(100 char),
    ACCOUNTGROUP      VARCHAR2(10 char)
        constraint BA_ACCOUNTGROUP_CC
            check (accountGroup IN ('INTERNAL', 'EXTERNAL')),
    HLPRODUCTID       NUMBER(19)
        constraint VP_BA
            references HLPRODUCT,
    RECEIVECHAPSONLY  NUMBER(3) default 0 not null
);

create table ACCOUNTREPORTFILE
(
    ACCOUNTREPORTFILEID NUMBER(19)        not null
        constraint ARF_PK
            primary key,
    BANKACCOUNTID       NUMBER(19)        not null
        constraint ARF_BA
            references BANKACCOUNT,
    FILECONTENT         CLOB              not null,
    TRANSMITTEDUTC      TIMESTAMP(6)      not null,
    MESSAGEID           VARCHAR2(35 char) not null,
    PROCESSID           VARCHAR2(35 char) not null,
    FILECONTENTSHA1     RAW(20)
        constraint ARF_FILECONTENTSHA1_CC
            check (FileContentSHA1 IS NULL OR LENGTH(FileContentSHA1) = 40)
);

create index FK1_ACCOUNTREPORTFILE
    on ACCOUNTREPORTFILE (BANKACCOUNTID);

create index IDX2_ACCOUNTREPORTFILE
    on ACCOUNTREPORTFILE (FILECONTENTSHA1);

create index IDX1_ACCOUNTREPORTFILE
    on ACCOUNTREPORTFILE (PROCESSID);

create table ACCOUNTSTATEMENTLINE
(
    ACCOUNTSTATEMENTLINEID       NUMBER(19)        not null
        primary key,
    VALUEUTC                     TIMESTAMP(6)      not null,
    ENTRYUTC                     TIMESTAMP(6),
    DEBITCREDITMARK              VARCHAR2(2 char)  not null
        constraint ASL_DEBITCREDITMARK_CC
            check (debitCreditMark IN ('C', 'D', 'RC', 'RD')),
    FUNDSCODE                    CHAR,
    AMOUNT                       NUMBER(19, 2)     not null,
    TXTYPE                       CHAR,
    IDCODE                       CHAR(3),
    OWNERACCTREFERENCE           VARCHAR2(32 char),
    SERVICINGREFERENCE           VARCHAR2(32 char),
    DETAILS                      VARCHAR2(64 char),
    FIELD86                      VARCHAR2(390 char),
    BANKACCOUNTID                NUMBER(19)        not null
        constraint ASL_BA
            references BANKACCOUNT,
    TXREFERENCE                  VARCHAR2(16 char) not null,
    PARENTACCOUNTSTATEMENTLINEID NUMBER(19)
        constraint ASL_PARENTASL
            references ACCOUNTSTATEMENTLINE
);

create index FK2_ACCOUNTSTATEMENTLINE
    on ACCOUNTSTATEMENTLINE (PARENTACCOUNTSTATEMENTLINEID);

create index FK1_ACCOUNTSTATEMENTLINE
    on ACCOUNTSTATEMENTLINE (BANKACCOUNTID);

create table ASF2ASL
(
    ACCOUNTSTATEMENTFILEID NUMBER(19) not null
        constraint ASF_ASF2ASL
            references ACCOUNTSTATEMENTFILE,
    ACCOUNTSTATEMENTLINEID NUMBER(19) not null
        constraint ASL_ASF2ASL
            references ACCOUNTSTATEMENTLINE,
    primary key (ACCOUNTSTATEMENTFILEID, ACCOUNTSTATEMENTLINEID)
);

create index FK2_ASF2ASL
    on ASF2ASL (ACCOUNTSTATEMENTLINEID);

create index FK1_ASF2ASL
    on ASF2ASL (ACCOUNTSTATEMENTFILEID);

create table ASF2BANKACCOUNT
(
    ACCOUNTSTATEMENTFILEID NUMBER(19) not null
        constraint ASF_ASF2BA
            references ACCOUNTSTATEMENTFILE,
    BANKACCOUNTID          NUMBER(19) not null
        constraint BA_ASF2BA
            references BANKACCOUNT,
    primary key (ACCOUNTSTATEMENTFILEID, BANKACCOUNTID)
);

create index FK2_ASF2BANKACCOUNT
    on ASF2BANKACCOUNT (BANKACCOUNTID);

create index FK1_ASF2BANKACCOUNT
    on ASF2BANKACCOUNT (ACCOUNTSTATEMENTFILEID);

create table BACSCONFIGURATION
(
    BACSCONFIGURATIONID    NUMBER(19) not null
        primary key,
    ISACLEARERACCOUNTID    NUMBER(19) not null
        constraint BA_BACSCFG_ISA
            references BANKACCOUNT,
    NONISACLEARERACCOUNTID NUMBER(19) not null
        constraint BA_BACSCFG_NONISA
            references BANKACCOUNT,
    FEESACCOUNTID          NUMBER(19) not null
        constraint BA_BACSCFC_FEES
            references BANKACCOUNT
);

create index FK1_BACSCONFIGURATION
    on BACSCONFIGURATION (FEESACCOUNTID);

create index FK2_BACSCONFIGURATION
    on BACSCONFIGURATION (ISACLEARERACCOUNTID);

create index FK3_BACSCONFIGURATION
    on BACSCONFIGURATION (NONISACLEARERACCOUNTID);

create unique index AK2_BANKACCOUNT
    on BANKACCOUNT (ACCOUNTIDENTIFIER);

create index FK1_BANKACCOUNT
    on BANKACCOUNT (PARTNERBANKID);

create index IDX1_BANKACCOUNT
    on BANKACCOUNT (PROCESSID);

create index FK2_BANKACCOUNT
    on BANKACCOUNT (HLPRODUCTID);

create unique index AK1_BANKACCOUNT
    on BANKACCOUNT (TREASURYBLOCKID);

create index IDX2_BANKACCOUNT
    on BANKACCOUNT (ACCOUNTTYPE);

create table CASHACCOUNT
(
    CASHACCOUNTID       NUMBER(19)                             not null
        primary key,
    CUSTOMERID          NUMBER(19)
        constraint CU_CA
            references CUSTOMER,
    BANKACCOUNTID       NUMBER(19)
        constraint BA_CA
            references BANKACCOUNT,
    CASHACCOUNTTYPEID   NUMBER(19)                             not null
        constraint CAT_CA
            references CASHACCOUNTTYPE,
    PARENTCASHACCOUNTID NUMBER(19)
        constraint CA_CA
            references CASHACCOUNT,
    INSTRUMENTID        NUMBER(19)
        constraint FKCASHACCOUN532375
            references INSTRUMENT,
    AMOUNT              NUMBER(19, 2)     default 0            not null,
    AATI                NUMBER(19, 2)     default 0            not null,
    AATW                NUMBER(19, 2)     default 0            not null,
    AATT                NUMBER(19, 2)     default 0            not null,
    UPDATEDUTC          TIMESTAMP(6)      default SYSTIMESTAMP not null,
    CREATEDUTC          TIMESTAMP(6)                           not null,
    STATUS              VARCHAR2(15 char) default 'ACTIVE'     not null
        constraint CA_STATUS_CC
            check (status IN
                   ('ACTIVE', 'CLOSED', 'DECEASED', 'MLCHECKS', 'PENDINGCLOSURE', 'SUSPENDED')),
    TAATI               NUMBER(19, 2)     default 0            not null,
    TAATW               NUMBER(19, 2)     default 0            not null,
    TAATT               NUMBER(19, 2)     default 0            not null,
    DEFAULTSPSWEEPUTC   TIMESTAMP(6)      default NULL,
    PSD2WHITELISTEDUTC  TIMESTAMP(6)      default NULL
);

create table CARDPAYMENT
(
    CARDPAYMENTID  NUMBER(19)        not null
        primary key,
    TAGID          VARCHAR2(50 char) not null,
    AUTHCODE       VARCHAR2(50 char),
    PROVIDER       VARCHAR2(30 char) not null,
    REQUESTEDUTC   TIMESTAMP(6)      not null,
    AUTHUTC        TIMESTAMP(6)      not null,
    PANDETAILS     VARCHAR2(4 char),
    CASHACCOUNTID  NUMBER(19)        not null
        constraint CA_CP
            references CASHACCOUNT,
    GENERICORDERID NUMBER(19)        not null
        constraint ORD_CP
            references GENERICORDER,
    MARK           VARCHAR2(2 char)  not null
        constraint CP_MARK_CC
            check (mark IN ('C', 'D'))
);

create unique index FK2_CARDPAYMENT
    on CARDPAYMENT (GENERICORDERID);

create index FK1_CARDPAYMENT
    on CARDPAYMENT (CASHACCOUNTID);

create index IDX1_CARDPAYMENT
    on CARDPAYMENT (TAGID);

create index FK2_CASHACCOUNT
    on CASHACCOUNT (PARENTCASHACCOUNTID);

create index FK1_CASHACCOUNT
    on CASHACCOUNT (CUSTOMERID);

create index FK3_CASHACCOUNT
    on CASHACCOUNT (CASHACCOUNTTYPEID);

create index FK4_CASHACCOUNT
    on CASHACCOUNT (BANKACCOUNTID);

create index FK5_CASHACCOUNT
    on CASHACCOUNT (INSTRUMENTID);

create table CASHACCOUNTBALANCE
(
    CASHACCOUNTBALANCEID NUMBER(19)              not null
        primary key,
    CASHACCOUNTID        NUMBER(19)              not null
        constraint CAB_CA
            references CASHACCOUNT,
    AMOUNT               NUMBER(19, 2) default 0 not null,
    VALUEUTC             TIMESTAMP(6)            not null,
    ORDINAL              NUMBER(19)              not null
);

create unique index AK1_CASHACCOUNTBALANCE
    on CASHACCOUNTBALANCE (CASHACCOUNTID, VALUEUTC, ORDINAL);

create index FK1_CASHACCOUNTBALANCE
    on CASHACCOUNTBALANCE (CASHACCOUNTID);

create table CASHACCOUNTOPENING
(
    CASHACCOUNTOPENINGID NUMBER(19)         not null
        primary key,
    CASHACCOUNTID        NUMBER(19)
        constraint CAO_CA
            references CASHACCOUNT,
    RECEIPTTYPE          VARCHAR2(255 char) not null,
    SOURCECODE           VARCHAR2(255 char)
);

create index FK1_CASHACCOUNTOPENING
    on CASHACCOUNTOPENING (CASHACCOUNTID);

create table CASHMOVEMENT
(
    CASHMOVEMENTID NUMBER(19)                   not null
        primary key,
    CASHACCOUNTID  NUMBER(19)                   not null
        constraint CA_CM
            references CASHACCOUNT,
    MARK           VARCHAR2(2 char) default 'C' not null
        constraint CM_MARK_CC
            check (mark IN ('D', 'C', 'RC', 'RD')),
    CREATEDUTC     TIMESTAMP(6)                 not null
);

create table ACCOUNTCLOSE
(
    ACCOUNTCLOSEID           NUMBER(19)         not null
        primary key,
    SYNCHRONIZATIONPROCESSID NUMBER(19)
        constraint ACCOUNTCLOSE_PROCESSID
            references SYNCHRONIZATIONPROCESS
                on delete cascade,
    BIC                      VARCHAR2(11 char)  not null,
    REFERENCE                VARCHAR2(36 char)  not null,
    IBAN                     VARCHAR2(34 char)  not null,
    POOLEDIBAN               VARCHAR2(34 char)  not null,
    REQUESTSENTUTC           TIMESTAMP(6),
    PROCESSID                VARCHAR2(35 char)  not null,
    MESSAGEID                VARCHAR2(50 char)  not null,
    TITLE                    VARCHAR2(10 char)  not null,
    FIRSTNAME                VARCHAR2(50 char)  not null,
    SURNAME                  VARCHAR2(50 char)  not null,
    BIRTHCOUNTRY             VARCHAR2(255 char) not null,
    DOB                      DATE               not null,
    NATIONALINSURANCENUMBER  VARCHAR2(25 char)  not null,
    EMAILADDRESS             VARCHAR2(255 char) not null,
    GENDER                   VARCHAR2(10 char)  not null,
    INSTRUMENTID             NUMBER(19)
        constraint FK_AC_INST
            references INSTRUMENT,
    CASHMOVEMENTID           NUMBER(19)         not null
        constraint CM_AC
            references CASHMOVEMENT
);

create index FK1_ACCOUNTCLOSE
    on ACCOUNTCLOSE (SYNCHRONIZATIONPROCESSID);

create unique index AK3_ACCOUNTCLOSE
    on ACCOUNTCLOSE (REFERENCE);

create index FK2_ACCOUNTCLOSE
    on ACCOUNTCLOSE (INSTRUMENTID);

create unique index AK4_ACCOUNTCLOSE
    on ACCOUNTCLOSE (PROCESSID);

create index FK3_ACCOUNTCLOSE
    on ACCOUNTCLOSE (CASHMOVEMENTID);

create unique index AK1_ACCOUNTCLOSE
    on ACCOUNTCLOSE (MESSAGEID);

create unique index AK2_ACCOUNTCLOSE
    on ACCOUNTCLOSE (IBAN);

create table ASL2CM
(
    ACCOUNTSTATEMENTLINEID NUMBER(19)          not null
        constraint ASL_ASL2CM
            references ACCOUNTSTATEMENTLINE,
    CASHMOVEMENTID         NUMBER(19)          not null
        constraint CM_ASL2CM
            references CASHMOVEMENT,
    MANUALLYRECONCILED     NUMBER(3) default 0 not null
        check (manuallyReconciled in (0, 1)),
    primary key (ACCOUNTSTATEMENTLINEID, CASHMOVEMENTID)
);

create unique index AK1_ASL2CM
    on ASL2CM (CASHMOVEMENTID);

create index AK2_ASL2CM
    on ASL2CM (ACCOUNTSTATEMENTLINEID);

create index FK1_CASHMOVEMENT
    on CASHMOVEMENT (CASHACCOUNTID);

create table CASHMOVEMENT2GENERICORDER
(
    CASHMOVEMENTID NUMBER(19) not null
        constraint CM_CM2ORD
            references CASHMOVEMENT,
    GENERICORDERID NUMBER(19) not null
        constraint ORD_CM2ORD
            references GENERICORDER,
    constraint AK1_CM2ORDER
        primary key (CASHMOVEMENTID, GENERICORDERID)
);

create index FK1_CASHMOVEMENT2GENERICORDER
    on CASHMOVEMENT2GENERICORDER (CASHMOVEMENTID);

create index FK2_CASHMOVEMENT2GENERICORDER
    on CASHMOVEMENT2GENERICORDER (GENERICORDERID);

create table CLEARERBANK
(
    CLEARERBANKID          NUMBER(19)        not null
        primary key,
    BIC                    VARCHAR2(20 char) not null,
    BANKMESSAGINGPROFILEID NUMBER(19)        not null
        constraint CB_BMP
            references BANKMESSAGINGPROFILE,
    NONISABANKACCOUNTID    NUMBER(19)        not null
        constraint BA_CB_NONISA
            references BANKACCOUNT,
    ISABANKACCOUNTID       NUMBER(19)        not null
        constraint BA_CB_ISA
            references BANKACCOUNT,
    FIRMREFERENCENUMBER    NUMBER(20),
    MT940SCHEDULEID        NUMBER(19)
        constraint FK_CB_MT940
            references MT940SCHEDULE
);

create unique index AK2_CLEARERBANK
    on CLEARERBANK (ISABANKACCOUNTID);

create index FK1_CLEARERBANK
    on CLEARERBANK (BANKMESSAGINGPROFILEID);

create unique index AK1_CLEARERBANK
    on CLEARERBANK (NONISABANKACCOUNTID);

create table CLIENTSTATEMENT
(
    CLIENTSTATEMENTID NUMBER(19)           not null
        primary key,
    CASHACCOUNTID     NUMBER(19)           not null
        constraint CS_CA
            references CASHACCOUNT,
    STATEMENTYEAR     NUMBER(4)            not null,
    STATEMENTMONTH    NUMBER(2)            not null,
    STATEMENT         BLOB,
    FAILURES          NUMBER(19) default 0 not null,
    constraint CS_UNIQ
        unique (CASHACCOUNTID, STATEMENTYEAR, STATEMENTMONTH)
);

create table HLAMBANK
(
    HLAMBANKID    NUMBER(19)        not null
        primary key,
    BIC           VARCHAR2(11 char) not null
        check (LENGTH(bic) = 8 OR LENGTH(bic) = 11),
    BANKACCOUNTID NUMBER(19)        not null
        constraint BA_HLAMB
            references BANKACCOUNT
);

create index FK1_HLAMBANK
    on HLAMBANK (BANKACCOUNTID);

create table INSTRUCTIONORDER
(
    INSTRUCTIONORDERID     NUMBER(19)                          not null
        primary key,
    CASHACCOUNTID          NUMBER(19)                          not null
        constraint CA_IO
            references CASHACCOUNT
                on delete cascade,
    INSTRUMENTID           NUMBER(19)                          not null
        constraint INS_IO
            references INSTRUMENT,
    MARK                   VARCHAR2(2 char)  default 'C'       not null
        constraint IO_MARK_CC
            check (mark IN ('D', 'C', 'RC', 'RD')),
    TIMEINFORCE            VARCHAR2(5 char)                    not null
        constraint IO_TIMEINFORCE_CC
            check (timeInForce IN ('GTC', 'GTD')),
    STATUS                 VARCHAR2(20 char) default 'PENDING' not null
        constraint IO_STATUS_CC
            check (status IN
                   ('CANCELLED', 'PENDING', 'OPENING', 'SUBMITTED', 'COMPLETED', 'TRANSFERRED_PENDING', 'TRANSFERRED',
                    'FUNDED', 'CUSTOMER_TRANSFER',
                    'PRE_SYNC_CHECKS_PASS', 'PAYMENT_INITIATED', 'PAYMENT_COMPLETED', 'SWEEPER_PENDING',
                    'FUNDING_PAYMENT', 'CUSTOMER_ALLOCATION')),
    UPDATEDUTC             TIMESTAMP(6)                        not null,
    PRESYNCCHECKSPASSEDUTC TIMESTAMP(6),
    GENERICORDERID         NUMBER(19)                          not null
        constraint ORD_INSORD
            references GENERICORDER,
    PRESYNCFAILUREREASON   VARCHAR2(255 char),
    ACTIONONBEHALFBYID     NUMBER(19)
        references INTERNALUSER,
    ACTIONONBEHALFSOURCE   VARCHAR2(15 char)
        constraint IO_ACTIONONBEHALFSOURCE_CC
            check (actionOnBehalfSource IN ('TELEPHONE', 'POST', 'DEFAULT_SP', 'TRANSFER_OUT')),
    ORDERTYPE              VARCHAR2(16 char) default NULL
);

create table ACCOUNTOPEN
(
    ACCOUNTOPENID               NUMBER(19)         not null
        primary key,
    SYNCHRONIZATIONPROCESSID    NUMBER(19)
        constraint ACCOUNTOPEN_PROCESSID
            references SYNCHRONIZATIONPROCESS
                on delete cascade,
    INSTRUMENTID                NUMBER(19)         not null
        constraint INS_AO
            references INSTRUMENT,
    BIC                         VARCHAR2(11 char)  not null,
    REFERENCE                   VARCHAR2(36 char)  not null,
    PROCESSID                   VARCHAR2(35 char)  not null,
    MESSAGEID                   VARCHAR2(50 char)  not null,
    TITLE                       VARCHAR2(20 char)  not null,
    FIRSTNAME                   VARCHAR2(50 char)  not null,
    SURNAME                     VARCHAR2(50 char)  not null,
    BIRTHCOUNTRY                VARCHAR2(255 char) not null,
    DOB                         DATE               not null,
    EMAILADDRESS                VARCHAR2(255 char) not null,
    INSTRUMENTEXTERNALREFERENCE VARCHAR2(255 char) not null,
    OPENINGAMOUNT               NUMBER(30, 16),
    REQUESTSENTUTC              TIMESTAMP(6),
    INSTRUMENTEFFECTIVEDATEUTC  TIMESTAMP(6),
    GENDER                      VARCHAR2(10 char)  not null,
    CASHMOVEMENTID              NUMBER(19)
        constraint FK_AO_CM
            references CASHMOVEMENT,
    ADDRESS                     VARCHAR2(490 char) not null,
    POSTCODE                    VARCHAR2(16 char)  not null,
    COUNTRYOFRESIDENCE          CHAR(2)            not null,
    CUSTOMEREXTERNALREFERENCE   VARCHAR2(35 char)  not null,
    INSTRUCTIONORDERID          NUMBER(19)         not null
        constraint AO_IO
            references INSTRUCTIONORDER
);

create unique index AK3_ACCOUNTOPEN
    on ACCOUNTOPEN (PROCESSID);

create unique index AK1_ACCOUNTOPEN
    on ACCOUNTOPEN (MESSAGEID);

create index FK3_ACCOUNTOPEN
    on ACCOUNTOPEN (CASHMOVEMENTID);

create index FK4_ACCOUNTOPEN
    on ACCOUNTOPEN (INSTRUCTIONORDERID);

create unique index AK2_ACCOUNTOPEN
    on ACCOUNTOPEN (REFERENCE);

create index FK1_ACCOUNTOPEN
    on ACCOUNTOPEN (SYNCHRONIZATIONPROCESSID);

create index FK2_ACCOUNTOPEN
    on ACCOUNTOPEN (INSTRUMENTID);

create table ACCOUNTOPEN2ACCOUNTOPENFILE
(
    ACCOUNTOPENFILEID NUMBER       not null
        constraint AOF_AO2AOF
            references ACCOUNTOPENFILE,
    ACCOUNTOPENID     NUMBER       not null
        constraint AO_AO2AOF
            references ACCOUNTOPEN,
    TRANSMITTEDUTC    TIMESTAMP(6) not null,
    constraint ACCOUNTOPEN2ACCOUNTOPENFIL_PK
        primary key (ACCOUNTOPENFILEID, ACCOUNTOPENID)
);

create table ACCOUNTOPEN2ACCOUNTREPORTFILE
(
    ACCOUNTREPORTFILEID NUMBER(19) not null
        constraint AO2ARF_ARF
            references ACCOUNTREPORTFILE,
    ACCOUNTOPENID       NUMBER(19) not null
        constraint AO2ARF_AO
            references ACCOUNTOPEN,
    constraint AO2ARF_PK
        primary key (ACCOUNTREPORTFILEID, ACCOUNTOPENID)
);

create index FK1_ACCOUNTOPEN2ARF
    on ACCOUNTOPEN2ACCOUNTREPORTFILE (ACCOUNTOPENID);

create index FK2_ACCOUNTOPEN2ARF
    on ACCOUNTOPEN2ACCOUNTREPORTFILE (ACCOUNTREPORTFILEID);

create index FK2_INSTRUCTIONORDER
    on INSTRUCTIONORDER (INSTRUMENTID);

create index IDX6_LOANORDER
    on INSTRUCTIONORDER (STATUS);

create unique index FK3_INSTRUCTIONORDER
    on INSTRUCTIONORDER (GENERICORDERID);

create index FK1_INSTRUCTIONORDER
    on INSTRUCTIONORDER (CASHACCOUNTID);

create table INTERESTORDER
(
    INTERESTORDERID NUMBER(19)        not null
        constraint PK_INTERESTORDER
            primary key,
    CASHACCOUNTID   NUMBER(19)        not null
        constraint IO_CA
            references CASHACCOUNT,
    INSTRUMENTID    NUMBER(19)        not null
        constraint IO_I
            references INSTRUMENT,
    STATUS          VARCHAR2(30 char) not null
        constraint INTORD_STATUS_CC
            check (status IN
                   ('PENDING', 'PA_AWAITINGROUNDINGADJUSTMENT', 'PA_FUNDED', 'PA2HUB_TRANSFERRED', 'COMPLETED',
                    'CANCELLED')),
    UPDATEDUTC      TIMESTAMP(6)      not null,
    GENERICORDERID  NUMBER(19)        not null
        constraint ORD_INTORD
            references GENERICORDER
);

create index FK1_INTERESTORDER
    on INTERESTORDER (CASHACCOUNTID);

create unique index FK3_INTERESTORDER
    on INTERESTORDER (GENERICORDERID);

create index FK2_INTERESTORDER
    on INTERESTORDER (INSTRUMENTID);

create table IO2SP
(
    SYNCHRONIZATIONPROCESSID NUMBER(19) not null
        constraint SP_IPO2SP
            references SYNCHRONIZATIONPROCESS,
    INSTRUCTIONORDERID       NUMBER(19) not null
        constraint INSTRORD_IO2SP
            references INSTRUCTIONORDER,
    primary key (SYNCHRONIZATIONPROCESSID, INSTRUCTIONORDERID)
);

create index FK2_IO2SP
    on IO2SP (INSTRUCTIONORDERID);

create index FK1_IO2SP
    on IO2SP (SYNCHRONIZATIONPROCESSID);

create table ISATRANSFERORDER
(
    ISATRANSFERORDERID NUMBER(19)           not null
        primary key,
    CASHACCOUNTID      NUMBER(19)           not null
        constraint CA_ITO
            references CASHACCOUNT,
    GENERICORDERID     NUMBER(19)           not null
        constraint ORD_ITO
            references GENERICORDER,
    CREATEDBYID        NUMBER(19)           not null
        constraint CREATEDBY_ITO
            references INTERNALUSER,
    APPROVEDBYID       NUMBER(19)
        constraint APPROVEDBY_ITO
            references INTERNALUSER,
    MARK               VARCHAR2(1 char)     not null
        constraint ITO_MARK_CC
            check (mark IN ('C', 'D')),
    ISCHEQUE           NUMBER(3)            not null,
    PROVIDER           VARCHAR2(100 char)   not null,
    ACCOUNTNAME        VARCHAR2(100 char)   not null,
    ACCOUNTIDENTIFIER  VARCHAR2(35 char),
    TRANSFERREFERENCE  VARCHAR2(100 char)   not null,
    STATUS             VARCHAR2(16 char)    not null
        constraint ITO_STATUS_CC
            check (status IN ('COMPLETED', 'REJECTED', 'CANCELLED', 'APPROVED', 'SEND_REJECTED', 'REQUESTED', 'SENT')),
    TYPE               VARCHAR2(17 char)    not null
        constraint ITO_TYPE_CC
            check (type IN ('FULL', 'PARTIAL', 'RESIDUAL_INTEREST')),
    REJECTEDCOUNTER    NUMBER(10) default 0 not null
);

create index FK_CASHACCOUNT_ITO
    on ISATRANSFERORDER (CASHACCOUNTID);

create index FK_GENERICORDER_ITO
    on ISATRANSFERORDER (GENERICORDERID);

create index FK_CREATEDBY_ITO
    on ISATRANSFERORDER (CREATEDBYID);

create index FK_APPROVEDBY_ITO
    on ISATRANSFERORDER (APPROVEDBYID);

create table JOURNALENTRY
(
    JOURNALENTRYID     NUMBER(19)        not null
        constraint PK_JOURNALENTRY
            primary key,
    JOURNALID          NUMBER(19)        not null
        constraint JOURNAL_JE
            references JOURNAL,
    ORDINAL            NUMBER(19)        not null,
    AMOUNT             NUMBER(19, 2)     not null,
    STATUS             VARCHAR2(10 char) not null
        constraint JE_STATUS_CC
            check (status IN ('DRAFT', 'FUTURE', 'BOOKED', 'CANCELLED')),
    MOVEMENTTYPE       VARCHAR2(15 char) not null
        constraint JE_MOVEMENTTYPE_CC
            check (movementType IN
                   ('CASH', 'TRADE', 'TAX', 'PnL', 'ACCRUAL', 'FEE', 'PENDING', 'ROUNDINGERROR', 'DAI', 'INVEST',
                    'PENALTY')),
    MOVEMENTSUBTYPE    VARCHAR2(20 char) not null
        constraint JE_MOVEMENTSUBTYPE_CC
            check (movementSubType IN
                   ('NONE', 'INTERNALTRANSFER', 'EXTERNALTRANSFER', 'WITHDRAWALFROMHUB', 'CARD', 'CHEQUE',
                    'SWITCHING')),
    REFERENCE          VARCHAR2(35 char) not null,
    CREATEDUTC         TIMESTAMP(6)      not null,
    VALUEUTC           TIMESTAMP(6)      not null,
    PROCESSINGSTARTUTC TIMESTAMP(6),
    RECONCILEDUTC      TIMESTAMP(6),
    FROMCASHMOVEMENTID NUMBER(19)
        constraint CM_JE_FROM
            references CASHMOVEMENT,
    TOCASHMOVEMENTID   NUMBER(19)
        constraint CM_JE_TO
            references CASHMOVEMENT,
    NARRATIVE          VARCHAR2(100 char),
    CREATEDBYID        NUMBER(19)        not null
        constraint IU_JE
            references INTERNALUSER
);

create index FK3_JOURNALENTRY
    on JOURNALENTRY (TOCASHMOVEMENTID);

create index FK2_JOURNALENTRY
    on JOURNALENTRY (FROMCASHMOVEMENTID);

create index FK1_JOURNALENTRY
    on JOURNALENTRY (JOURNALID);

create index FK4_JOURNALENTRY
    on JOURNALENTRY (CREATEDBYID);

create unique index AK1_JOURNALENTRY
    on JOURNALENTRY (JOURNALID, ORDINAL);

create index AK3_JOURNALENTRY
    on JOURNALENTRY (VALUEUTC);

create index AK2_JOURNALENTRY
    on JOURNALENTRY (RECONCILEDUTC, 1);

create table PAYMENT
(
    PAYMENTID         NUMBER(19)        not null
        primary key,
    EXTERNALREFERENCE VARCHAR2(35 char) not null
        constraint AK1_PAYMENT
            unique,
    PAYMENTTYPE       VARCHAR2(5 char)  not null
        constraint P_PAYMENTTYPE_CC
            check (paymentType IN ('BACS', 'FP', 'CHAPS', 'ICT')),
    STATUS            VARCHAR2(5 char)  not null
        constraint P_STATUS_CC
            check (status in ('RCVD', 'ACTC', 'RJCT', 'ACCP', 'ACSP', 'ACSC', 'PN')),
    AMOUNT            NUMBER(19, 2)     not null,
    CREATEDUTC        TIMESTAMP(6)      not null,
    MANUAL            NUMBER(3) default 0,
    SRCCASHMOVEMENTID NUMBER(19)
        constraint SRCCM_P
            references CASHMOVEMENT,
    DSTCASHMOVEMENTID NUMBER(19)
        constraint DSTCM_P
            references CASHMOVEMENT,
    SOURCE            VARCHAR2(100 char),
    SRCACCTIDENTIFIER VARCHAR2(50 char),
    DESTINATION       VARCHAR2(100 char),
    DSTACCTIDENTIFIER VARCHAR2(50 char)
);

create table ACCOUNTTRANSFER
(
    ACCOUNTTRANSFERID        NUMBER(19) not null
        primary key,
    SYNCHRONIZATIONPROCESSID NUMBER(19)
        constraint ACCOUNTTRANSFER_PROCESSID
            references SYNCHRONIZATIONPROCESS
                on delete cascade,
    INSTRUMENTID             NUMBER(19)
        constraint FK_AT_INST
            references INSTRUMENT,
    PAYMENTID                NUMBER(19) not null
        constraint FK_AT_P
            references PAYMENT
);

create index FK3_ACCOUNTTRANSFER
    on ACCOUNTTRANSFER (INSTRUMENTID);

create index FK1_ACCOUNTTRANSFER
    on ACCOUNTTRANSFER (SYNCHRONIZATIONPROCESSID);

create index FK5_ACCOUNTTRANSFER
    on ACCOUNTTRANSFER (PAYMENTID);

create table ISATRANSFERORDER2PAYMENT
(
    ISATRANSFERORDERID NUMBER(19) not null
        constraint ITO_ITO2P
            references ISATRANSFERORDER,
    PAYMENTID          NUMBER(19) not null
        constraint P_ITO
            references PAYMENT
);

create index FK_ITO_ITO2P
    on ISATRANSFERORDER2PAYMENT (ISATRANSFERORDERID);

create index FK_P_ITO2P
    on ISATRANSFERORDER2PAYMENT (PAYMENTID);

create unique index FK1_PAYMENT
    on PAYMENT (SRCCASHMOVEMENTID);

create unique index FK2_PAYMENT
    on PAYMENT (DSTCASHMOVEMENTID);

create table PAYMENTFILE
(
    PAYMENTFILEID     NUMBER(19)         not null
        primary key,
    BANKACCOUNTID     NUMBER(19)         not null
        constraint BA_PF
            references BANKACCOUNT,
    FILECONTENT       CLOB               not null,
    CREATEDUTC        TIMESTAMP(6)       not null,
    TRANSMITTEDUTC    TIMESTAMP(6)       not null,
    EXTERNALREFERENCE VARCHAR2(35 char)  not null
        constraint AK1_PAYMENTFILE
            unique,
    FILETYPE          VARCHAR2(20 char)  not null
        constraint PF_FILETYPE_CC
            check (filetype in ('MT', 'MX')),
    FILENAME          VARCHAR2(255 char) not null
);

create table PAYMENT2PAYMENTFILE
(
    PAYMENTID      NUMBER(19) not null
        constraint P_P2PF
            references PAYMENT,
    PAYMENTFILEID  NUMBER(19) not null
        constraint PF_P2PF
            references PAYMENTFILE,
    BATCHREFERENCE VARCHAR2(16 char),
    primary key (PAYMENTID, PAYMENTFILEID)
);

create index FK2_PAYMENT2PAYMENTFILE
    on PAYMENT2PAYMENTFILE (PAYMENTFILEID);

create index FK1_PAYMENT2PAYMENTFILE
    on PAYMENT2PAYMENTFILE (PAYMENTID);

create index FK1_PAYMENTFILE
    on PAYMENTFILE (BANKACCOUNTID);

create index PF_FILENAME_35
    on PAYMENTFILE (SUBSTR("FILENAME", 1, 35));

create table PAYMENTSTATUSFILE
(
    PAYMENTSTATUSFILEID NUMBER(19)   not null
        primary key,
    PAYMENTFILEID       NUMBER(19)   not null
        constraint PF_PSF
            references PAYMENTFILE,
    FILECONTENT         CLOB         not null,
    RECEIVEDUTC         TIMESTAMP(6) not null,
    FILECONTENTSHA1     RAW(20)
        constraint PSF_FILECONTENTSHA1_CC
            check (FileContentSHA1 IS NULL OR LENGTH(FileContentSHA1) = 40)
);

create index FK1_PAYMENTSTATUSFILE
    on PAYMENTSTATUSFILE (PAYMENTFILEID);

create index IDX1_PAYMENTSTATUSFILE
    on PAYMENTSTATUSFILE (FILECONTENTSHA1);

create table PAYMENTSTATUSREASONINFO
(
    PAYMENTSTATUSREASONINFOID NUMBER(19)   not null
        primary key,
    PAYMENTID                 NUMBER(19)   not null
        constraint P_PSRI
            references PAYMENT,
    REASONCODE                VARCHAR2(4 char),
    REASONPROPRIETARY         VARCHAR2(35 char),
    ADDITIONALINFO            VARCHAR2(400 char),
    CREATEDUTC                TIMESTAMP(6) not null
);

create index FK1_PAYMENTSTATUSREASONINFO
    on PAYMENTSTATUSREASONINFO (PAYMENTID);

create table PRINCIPALORDER
(
    PRINCIPALORDERID NUMBER(19)        not null
        constraint PK_PRINCIPALORDER
            primary key,
    CASHACCOUNTID    NUMBER(19)        not null
        constraint PO_CA
            references CASHACCOUNT,
    INSTRUMENTID     NUMBER(19)        not null
        constraint PO_I
            references INSTRUMENT,
    STATUS           VARCHAR2(20 char) not null
        constraint PO_STATUS_CC
            check (status IN ('PENDING', 'PA_FUNDED', 'PA2HUB_TRANSFERRED', 'COMPLETED', 'CANCELLED')),
    UPDATEDUTC       TIMESTAMP(6)      not null,
    GENERICORDERID   NUMBER(19)        not null
        constraint ORD_PRINORD
            references GENERICORDER
);

create index FK2_PRINCIPALORDER
    on PRINCIPALORDER (INSTRUMENTID);

create unique index FK3_PRINCIPALORDER
    on PRINCIPALORDER (GENERICORDERID);

create index FK1_PRINCIPALORDER
    on PRINCIPALORDER (CASHACCOUNTID);

create table PROXYCONNECTIONTOKEN
(
    TOKENID        NUMBER(19)         not null
        primary key,
    INTERNALUSERID NUMBER(19)         not null
        constraint IU_PCT
            references INTERNALUSER,
    CASHACCOUNTID  NUMBER(19)         not null
        constraint CA_PCT
            references CASHACCOUNT,
    TOKEN          VARCHAR2(500 char) not null
);

create index FK1_PROXYCONNECTIONTOKEN
    on PROXYCONNECTIONTOKEN (INTERNALUSERID);

create index FK2_PROXYCONNECTIONTOKEN
    on PROXYCONNECTIONTOKEN (CASHACCOUNTID);

create table SWEEPERPROCESS
(
    SWEEPERPROCESSID NUMBER(19)        not null
        constraint AK1_SWEEPERPROCESS
            primary key,
    STATUS           VARCHAR2(30 char) not null
        constraint SP_STATUS_CC
            check (status IN ('AWAITING_CONFIRMATION', 'COMPLETED', 'FAILED')),
    CREATEDUTC       TIMESTAMP(6),
    CASHMOVEMENTID   NUMBER(19)        not null
        constraint CASHMOVEMENT_SP
            references CASHMOVEMENT
);

create index FK1_SWEEPERPROCESS
    on SWEEPERPROCESS (CASHMOVEMENTID);

create table TAG86FIELD
(
    TAG86FIELDID           NUMBER(19)         not null
        primary key,
    ACCOUNTSTATEMENTLINEID NUMBER(19)         not null
        constraint ASL_TAG86F
            references ACCOUNTSTATEMENTLINE,
    SOURCEKEY              VARCHAR2(100 char) not null,
    FIELDKEY               VARCHAR2(100 char),
    FIELDVALUE             VARCHAR2(255 char) not null
);

create index FK1_TAG86FIELD
    on TAG86FIELD (ACCOUNTSTATEMENTLINEID);

create table TB2SP
(
    TREASURYBLOCKID          NUMBER(19) not null
        constraint TB_TB2SP
            references TREASURYBLOCK,
    SYNCHRONIZATIONPROCESSID NUMBER(19) not null
        constraint SP_TB2SP
            references SYNCHRONIZATIONPROCESS,
    primary key (TREASURYBLOCKID, SYNCHRONIZATIONPROCESSID)
);

create index IDX2_TB2SP
    on TB2SP (SYNCHRONIZATIONPROCESSID);

create index IDX1_TB2SP
    on TB2SP (TREASURYBLOCKID);

create table TRANSFERORDER
(
    TRANSFERORDERID       NUMBER(19)                   not null
        primary key,
    CASHACCOUNTID         NUMBER(19)
        constraint TO_CA
            references CASHACCOUNT,
    HLPRODUCTID           NUMBER(19)
        constraint TO_VP
            references HLPRODUCT,
    STATUS                VARCHAR2(9 char)             not null
        constraint TO_STATUS_CC
            check (status IN ('REQUESTED', 'PENDING', 'SENT', 'REJECTED', 'COMPLETED', 'CANCELLED', 'FAILED')),
    REQUESTEDUTC          TIMESTAMP(6)                 not null,
    MSGREFERENCE          VARCHAR2(36 char),
    EXPECTEDBYUTC         TIMESTAMP(6)                 not null,
    CUSTOMERID            NUMBER(19)
        constraint TO_CU
            references CUSTOMER,
    FROMCUSTOMERID        NUMBER(19)                   not null
        constraint TO_FCID
            references CUSTOMER,
    TOCUSTOMERID          NUMBER(19)                   not null
        constraint TO_TCID
            references CUSTOMER,
    ACTIONONBEHALFSOURCE  VARCHAR2(20 char)
        constraint TO_ACTIONONBEHALFSOURCE_C
            check (actionOnBehalfSource IN ('TELEPHONE', 'POST', 'DORMANT_FUNDS')),
    GENERICORDERID        NUMBER(19)                   not null
        constraint ORD_TRFORD
            references GENERICORDER,
    MARK                  VARCHAR2(1 char) default 'D' not null
        constraint TO_MARK_CC
            check (Mark in ('D', 'C')),
    LINKEDTRANSFERORDERID NUMBER(19)
        constraint TO_LINKED
            references TRANSFERORDER
                on delete cascade
);

create index FK3_TRANSFERORDER
    on TRANSFERORDER (CUSTOMERID);

create index FK4_TRANSFERORDER
    on TRANSFERORDER (FROMCUSTOMERID);

create unique index FK6_TRANSFERORDER
    on TRANSFERORDER (GENERICORDERID);

create index FK5_TRANSFERORDER
    on TRANSFERORDER (TOCUSTOMERID);

create index FK1_TRANSFERORDER
    on TRANSFERORDER (CASHACCOUNTID);

create index FK2_TRANSFERORDER
    on TRANSFERORDER (HLPRODUCTID);

create table TRANSFERORDER2PAYMENT
(
    TRANSFERORDERID NUMBER(19) not null
        constraint TO2P_TO
            references TRANSFERORDER,
    PAYMENTID       NUMBER(19) not null
        constraint TO2P_P
            references PAYMENT,
    primary key (TRANSFERORDERID, PAYMENTID)
);

create index FK2_TRANSFERORDER2PAYMENT
    on TRANSFERORDER2PAYMENT (PAYMENTID);

create index FK1_TRANSFERORDER2PAYMENT
    on TRANSFERORDER2PAYMENT (TRANSFERORDERID);

create unique index AK2_TREASURYBLOCK
    on TREASURYBLOCK (BLOCKREFERENCE);

create index FK1_TREASURYBLOCK
    on TREASURYBLOCK (TRADEREFERENCE);

create table TREASURYBLOCKBALANCE
(
    TREASURYBLOCKBALANCEID   NUMBER(19)    not null
        constraint PK_TREASURYBLOCKBALANCE
            primary key,
    TREASURYBLOCKID          NUMBER(19)    not null
        constraint FKTREASURYBL126062
            references TREASURYBLOCK,
    TREASURYBLOCKSTATEMENTID NUMBER(19)    not null
        constraint FKTREASURYBL625185
            references TREASURYBLOCKSTATEMENT,
    AMOUNT                   NUMBER(19, 2) not null,
    TRADEDATE                DATE          not null,
    MATURITYDATE             DATE          not null,
    ORDERING                 NUMBER(19)    not null
);

create index FK1_TREASURYBLOCKBALANCE
    on TREASURYBLOCKBALANCE (TREASURYBLOCKID);

create index FK2_TREASURYBLOCKBALANCE
    on TREASURYBLOCKBALANCE (TREASURYBLOCKSTATEMENTID);

create table TREASURYBLOCKINTEREST
(
    TREASURYBLOCKINTERESTID NUMBER(19)    not null
        primary key,
    TREASURYBLOCKID         NUMBER(19)    not null
        constraint TB_TBI
            references TREASURYBLOCK,
    UPDATEDBYID             NUMBER(19)
        constraint IU_TBI_APPROVEDBY
            references INTERNALUSER,
    VALUEDATE               DATE          not null,
    POSTEDUTC               TIMESTAMP(6),
    AMOUNT                  NUMBER(19, 2) not null,
    CREATEDBYID             NUMBER(19)    not null
        constraint IU_TBI_CREATEDBY
            references INTERNALUSER,
    CREATEDUTC              TIMESTAMP(6)  not null,
    REJECTEDUTC             TIMESTAMP(6)
);

comment on column TREASURYBLOCKINTEREST.VALUEDATE is 'date when the trade shall enter into effect (value date)';

comment on column TREASURYBLOCKINTEREST.POSTEDUTC is 'timestamp when the trade was posted into the system';

create table TREASURYOPERATION
(
    TREASURYOPERATIONID      NUMBER(19)                        not null
        primary key,
    TREASURYBLOCKID          NUMBER(19)                        not null
        constraint FKTREASURYOP312511
            references TREASURYBLOCK,
    SYNCHRONIZATIONPROCESSID NUMBER(19)
        constraint SP_TO
            references SYNCHRONIZATIONPROCESS,
    SENDERREFERENCE          VARCHAR2(16 char),
    CONFIRMED                NUMBER(3)         default 0       not null
        constraint TO_CONFIRMED_CC
            check (confirmed in (0, 1)),
    ACTION                   VARCHAR2(4 char)                  not null
        constraint TO_ACTION_CC
            check (action in ('NEWT', 'DUPL', 'CANC', 'AMND')),
    TYPE                     VARCHAR2(4 char)                  not null
        constraint TO_TYPE_CC
            check (type in ('CONF', 'MATU', 'ROLL')),
    PARTYA                   VARCHAR2(11 char)                 not null
        constraint TO_PARTYA_CC
            check (LENGTH(partyA) = 8 OR LENGTH(partyA) = 11),
    PARTYB                   VARCHAR2(11 char)                 not null
        constraint TO_PARTYB_CC
            check (LENGTH(partyB) = 8 OR LENGTH(partyB) = 11),
    PRINCIPAL                NUMBER(19, 2)                     not null,
    RATE                     NUMBER(19, 10),
    INTEREST                 NUMBER(19, 2),
    CURRENCY                 VARCHAR2(3 char)  default 'GBP'   not null
        constraint TO_CURRENCY_CC
            check (currency in ('GBP')),
    MATURITYDATE             DATE,
    VALUEDATE                DATE                              not null,
    TRADEDATE                DATE                              not null,
    CREATEDUTC               TIMESTAMP(6)                      not null,
    NEXTINTERESTDUEDATE      DATE,
    SOURCE                   VARCHAR2(15 char) default 'MT320' not null
        constraint TOP_SOURCE_CC
            check (SOURCE IN ('MT320', 'MANUAL', 'MANUAL_OVERRIDE')),
    TREASURYBLOCKINTERESTID  NUMBER(19)
        constraint TBI_TOP
            references TREASURYBLOCKINTEREST
);

create table CASHMOVEMENT2TREASURYOPERATION
(
    CASHMOVEMENTID      NUMBER(19) not null
        constraint CM_CM2TO
            references CASHMOVEMENT,
    TREASURYOPERATIONID NUMBER(19) not null
        constraint TO_CM2TO
            references TREASURYOPERATION,
    constraint PK_CM2TO
        primary key (CASHMOVEMENTID, TREASURYOPERATIONID)
);

create index FK2_CM2TO
    on CASHMOVEMENT2TREASURYOPERATION (TREASURYOPERATIONID);

create index FK1_CM2TO
    on CASHMOVEMENT2TREASURYOPERATION (CASHMOVEMENTID);

create index FK1_TREASURYOPERATION
    on TREASURYOPERATION (TREASURYBLOCKID);

create index FK2_TREASURYOPERATION
    on TREASURYOPERATION (SYNCHRONIZATIONPROCESSID);

create table WITHDRAWALORDER
(
    WITHDRAWALORDERID             NUMBER(19)                      not null
        primary key,
    CASHACCOUNTID                 NUMBER(19)                      not null
        constraint CA_WO
            references CASHACCOUNT,
    STATUS                        VARCHAR2(17 char)  default NULL not null
        constraint WO_UPDATED_STATUS_CC
            check (status IN
                   ('REQUESTED', 'CANCELLED', 'CLEARED', 'APPROVED', 'REJECTED', 'PENDING_REJECTION', 'AUTHORISED',
                    'CONFIRMED', 'ACKNOWLEDGED', 'RECONCILED', 'CHECKED')),
    UPDATEDUTC                    TIMESTAMP(6)                    not null,
    REJECTEDCOUNTER               NUMBER(10)         default NULL not null,
    ACCOUNTHOLDER                 VARCHAR2(50 char),
    ACCOUNTNUMBER                 VARCHAR2(10 char),
    SORTCODE                      VARCHAR2(6 char),
    BUILDINGSOCIETY               VARCHAR2(18 char),
    MLSTATUS                      VARCHAR2(2 char)
        constraint WO_MLSTATUS_CC
            check (mlStatus IN ('E', 'F', 'R', 'M', 'A')),
    NBASTATUS                     VARCHAR2(7 char)
        constraint WO_NBASTATUS_CC
            check (NbaStatus IN ('A', 'P', 'L', 'E', 'O', 'N')),
    REJECTEDPAYMENTS              NUMBER(5),
    LASTREJECTEDREASONMESSAGE     VARCHAR2(300 char),
    CLEAREDUTC                    TIMESTAMP(6)       default NULL,
    PROCESSINGMETHOD              VARCHAR2(10 char)  default NULL not null
        constraint PROCESSING_METHOD_C
            check (ProcessingMethod IN ('AUTOMATIC', 'CHECKING')),
    REFERRED                      NUMBER(3)          default NULL not null
        check (referred in (0, 1)),
    STAFF                         NUMBER(3)          default NULL not null
        check (staff in (0, 1)),
    VERIFICATIONSTATUS            VARCHAR2(10 char)  default NULL
        constraint WO_VERIFICATIONSTATUS_CC
            check (VerificationStatus IN ('E', 'M', 'F')),
    HLRELATIONSHIP                VARCHAR2(10 char)  default NULL not null
        check (hlRelationship in ('<3M', '3M<5Y', '5Y+')),
    NBACHANGEUTC                  TIMESTAMP(6)       default NULL,
    MPCHANGEUTC                   TIMESTAMP(6)       default NULL,
    MPSTATUS                      VARCHAR2(10 char)  default NULL not null
        check (mpStatus in ('PENDING', 'LOCK', 'INACTIVE', 'FAIL', 'PASS', 'ONLINE')),
    PACHANGEUTC                   TIMESTAMP(6)       default NULL,
    EMAILCHANGEUTC                TIMESTAMP(6)       default NULL,
    PAYMENTMETHODSTATUS           VARCHAR2(105 char) default NULL not null
        constraint WO_PAYMENTMETHODSTATUS_C
            check (PAYMENTMETHODSTATUS IN ('SYSTEM', 'USER')),
    CLIENTRISKRATING              VARCHAR2(10 char)  default NULL not null
        check (clientRiskRating in ('A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3')),
    MLCHECKS                      VARCHAR2(20 char)
        check (MLCHECKS IN ('P', 'F', 'R', 'E', 'CA', 'NU', 'MI')),
    PAYMENTDESTINATION            VARCHAR2(12 char)
        constraint WO_PAYMENTDESTINATION_C
            check (PaymentDestination IN ('CHEQUE', 'BANKTRANSFER', 'DCREFUND', 'NBA')),
    SUBSTATUS                     VARCHAR2(20 char)
        constraint WO_SUBSTATUS_C
            check (SUBSTATUS in ('BANK-REJECTED')),
    LOCKEDBY                      NUMBER(19)
        constraint WO_IU_LOCKEDBY_CC
            references INTERNALUSER,
    LOCKEDUTC                     TIMESTAMP(6),
    PREVIOUSSTATUS                VARCHAR2(17 char)
        constraint WO_PREVIOUS_STATUS_CC
            check (PREVIOUSSTATUS in
                   ('REQUESTED', 'CLEARED', 'APPROVED', 'PENDING_REJECTION', 'AUTHORISED', 'CONFIRMED', 'CHECKED',
                    'ACKNOWLEDGED')),
    APPROVEDBYID                  NUMBER(19)
        constraint WO_IU_APPROVEDBYID
            references INTERNALUSER,
    LASTACTIONBYID                NUMBER(19)
        constraint WO_IU_LASTACTIONBYID
            references INTERNALUSER,
    ACTIONONBEHALFBYID            NUMBER(19)
        constraint WO_IO_ACTIONONBEHALFBYID
            references INTERNALUSER,
    ACTIONONBEHALFSOURCE          VARCHAR2(20 char)
        constraint WO_ACTIONONBEHALFSOURCE_C
            check (ACTIONONBEHALFSOURCE IN ('TELEPHONE', 'POST', 'DORMANT_FUNDS')),
    PAYMENTDETAILSLASTUPDATEDBYID NUMBER(19)
        constraint WO_IU_PAYMENTDETAILSUPDATEDBY
            references INTERNALUSER,
    CLEAREDPLUSONEUTC             TIMESTAMP(6),
    REQUESTEDAMOUNT               NUMBER(19, 2)                   not null,
    GENERICORDERID                NUMBER(19)                      not null
        constraint ORD_WDWORD
            references GENERICORDER
);

comment on table WITHDRAWALORDER is 'Any withdrawalorder has a cashmovement; movementtype=RESERVED. Once the withdrawal is authorized and sent that withdrawalorder cashmovement is reversed and 2 proper journal entries are inserted; 54 to IN and IN to IB.
At this moment a payment record is created linked to the IB cashmovement.';

comment on column WITHDRAWALORDER.REJECTEDCOUNTER is 'Number of times the withdrawal has been tried.';

comment on column WITHDRAWALORDER.REFERRED is 'Denotes whether the action has been referred to the supervisor.';

comment on column WITHDRAWALORDER.HLRELATIONSHIP is 'How long the customer has been with HL';

comment on column WITHDRAWALORDER.PACHANGEUTC is 'Postal Address CHANGE UTC';

create table WITHDRAWALNOTE
(
    WITHDRAWALNOTEID  NUMBER(19)                                                                             not null
        primary key,
    WITHDRAWALORDERID NUMBER(19)                                                                             not null
        constraint WO_WN
            references WITHDRAWALORDER,
    NOTE              CLOB                                                                                   not null,
    CREATEDBY         VARCHAR2(50 char) default ''                                                           not null,
    CREATEDUTC        TIMESTAMP(6)      default TO_TIMESTAMP('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') not null
);

create index FK1_WITHDRAWALNOTES
    on WITHDRAWALNOTE (WITHDRAWALORDERID);

create index FK2_WITHDRAWALORDER
    on WITHDRAWALORDER (LOCKEDBY);

create index FK3_WITHDRAWALORDER
    on WITHDRAWALORDER (APPROVEDBYID);

create index FK5_WITHDRAWALORDER
    on WITHDRAWALORDER (PAYMENTDETAILSLASTUPDATEDBYID);

create index FK1_WITHDRAWALORDER
    on WITHDRAWALORDER (CASHACCOUNTID);

create index FK4_WITHDRAWALORDER
    on WITHDRAWALORDER (ACTIONONBEHALFBYID);

create index FK6_WITHDRAWALORDER
    on WITHDRAWALORDER (LASTACTIONBYID);

create unique index FK7_WITHDRAWALORDER
    on WITHDRAWALORDER (GENERICORDERID);

create table WITHDRAWALORDER2CARDPAYMENT
(
    CARDPAYMENTID     NUMBER(19) not null
        constraint CP_WDORD2CP
            references CARDPAYMENT,
    WITHDRAWALORDERID NUMBER(19) not null
        constraint WDORD_WDORD2CP
            references WITHDRAWALORDER,
    primary key (CARDPAYMENTID, WITHDRAWALORDERID)
);

create index FK2_WDORDER2CARDPAYMENT
    on WITHDRAWALORDER2CARDPAYMENT (WITHDRAWALORDERID);

create index FK1_WDORDER2CARDPAYMENT
    on WITHDRAWALORDER2CARDPAYMENT (CARDPAYMENTID);

alter table WITHDRAWALORDER2CARDPAYMENT
    add constraint UNIQUE_WDORD2CP
        unique (CARDPAYMENTID);

create table WITHDRAWALORDER2PAYMENT
(
    PAYMENTID         NUMBER(19) not null
        constraint P_WO2P
            references PAYMENT,
    WITHDRAWALORDERID NUMBER(19) not null
        constraint WO_WO2P
            references WITHDRAWALORDER
);

create index FK1_WITHDRAWALORDER2PAYMENT
    on WITHDRAWALORDER2PAYMENT (PAYMENTID);

create index FK2_WITHDRAWALORDER2PAYMENT
    on WITHDRAWALORDER2PAYMENT (WITHDRAWALORDERID);

create table WITHDRAWALORDERHISTORY
(
    WITHDRAWALORDERID             NUMBER(19),
    TRANSACTIONID                 NUMBER(19),
    CASHACCOUNTID                 NUMBER(19),
    STATUS                        VARCHAR2(17 char),
    UPDATEDUTC                    TIMESTAMP(6),
    REJECTEDCOUNTER               NUMBER(10),
    ACCOUNTHOLDER                 VARCHAR2(50 char),
    ACCOUNTNUMBER                 VARCHAR2(10 char),
    SORTCODE                      VARCHAR2(6 char),
    BUILDINGSOCIETY               VARCHAR2(18 char),
    MLSTATUS                      VARCHAR2(2 char),
    NBASTATUS                     VARCHAR2(7 char),
    REJECTEDPAYMENTS              NUMBER(5),
    LASTREJECTEDREASONMESSAGE     VARCHAR2(300 char),
    CLEAREDUTC                    TIMESTAMP(6)       default NULL,
    PROCESSINGMETHOD              VARCHAR2(10 char)  default NULL,
    REFERRED                      NUMBER(3)          default NULL,
    STAFF                         NUMBER(3)          default NULL,
    VERIFICATIONSTATUS            VARCHAR2(10 char)  default NULL,
    HLRELATIONSHIP                VARCHAR2(10 char)  default NULL,
    NBACHANGEUTC                  TIMESTAMP(6)       default NULL,
    MPCHANGEUTC                   TIMESTAMP(6)       default NULL,
    MPSTATUS                      VARCHAR2(10 char)  default NULL,
    PACHANGEUTC                   TIMESTAMP(6)       default NULL,
    EMAILCHANGEUTC                TIMESTAMP(6)       default NULL,
    PAYMENTMETHODSTATUS           VARCHAR2(105 char) default NULL,
    CLIENTRISKRATING              VARCHAR2(10 char)  default NULL,
    MLCHECKS                      VARCHAR2(20 char),
    PAYMENTDESTINATION            VARCHAR2(12 char),
    SUBSTATUS                     VARCHAR2(20 char),
    LOCKEDBY                      NUMBER(19),
    LOCKEDUTC                     TIMESTAMP(6),
    PREVIOUSSTATUS                VARCHAR2(17 char),
    APPROVEDBYID                  NUMBER(19),
    LASTACTIONBYID                NUMBER(19),
    ACTIONONBEHALFBYID            NUMBER(19),
    ACTIONONBEHALFSOURCE          VARCHAR2(20 char),
    PAYMENTDETAILSLASTUPDATEDBYID NUMBER(19),
    CLEAREDPLUSONEUTC             TIMESTAMP(6),
    REQUESTEDAMOUNT               NUMBER(19, 2),
    GENERICORDERID                NUMBER(19)
);

create table "schema_version"
(
    "installed_rank" NUMBER                                 not null
        constraint "schema_version_pk"
            primary key,
    "version"        VARCHAR2(50),
    "description"    VARCHAR2(200)                          not null,
    "type"           VARCHAR2(20)                           not null,
    "script"         VARCHAR2(1000)                         not null,
    "checksum"       NUMBER,
    "installed_by"   VARCHAR2(100)                          not null,
    "installed_on"   TIMESTAMP(6) default CURRENT_TIMESTAMP not null,
    "execution_time" NUMBER                                 not null,
    "success"        NUMBER(1)                              not null
);

create index "schema_version_s_idx"
    on "schema_version" ("success");

create table ORDERFORM
(
    ORDERFORMID   NUMBER(19)        not null
        constraint AK1_ORDERFORM
            primary key,
    CASHACCOUNTID NUMBER(19)        not null
        constraint OF_CA_CASHACCOUNTID
            references CASHACCOUNT,
    REFERENCE     VARCHAR2(22 char) not null,
    FORMTYPE      VARCHAR2(15 char) not null
        constraint OF_FORMTYPE_CC
            check (formType IN ('ISA_OPENING', 'ISA_TOP_UP', 'ASA_OPENING', 'PAY_BY_BANK')),
    STATUS        VARCHAR2(15 char) not null
        constraint OF_STATUS_CC
            check (status IN ('INPROGRESS', 'COMPLETE')),
    CREATEDUTC    TIMESTAMP(6)      not null
);

create index FK1_ORDERFORM
    on ORDERFORM (CASHACCOUNTID);

create unique index AK2_ORDERFORM
    on ORDERFORM (REFERENCE);

create table ISAORDERFORMDETAIL
(
    ISAORDERFORMDETAILID NUMBER(19)          not null
        primary key,
    ORDERFORMID          NUMBER(19)          not null
        constraint IOFD_OF_ORDERFORMID
            references ORDERFORM,
    INSTRUMENTID         NUMBER(19)
        constraint IOFD_I_INSTRUMENTID
            references INSTRUMENT,
    AMOUNT               NUMBER(19, 2),
    UPDATEDUTC           TIMESTAMP(6)        not null,
    ISASUBLASTTWOYEARS   NUMBER(3) default 0 not null
        check (isaSubLastTwoYears in (0, 1))
);

create index FK1_ISAORDERFORMDETAIL
    on ISAORDERFORMDETAIL (ORDERFORMID);

create index FK2_ISAORDERFORMDETAIL
    on ISAORDERFORMDETAIL (INSTRUMENTID);

create table FUNDINGPAYMENT
(
    SYNCHRONIZATIONPROCESSID NUMBER(19) not null
        constraint SP_FP
            references SYNCHRONIZATIONPROCESS,
    PAYMENTID                NUMBER(19) not null
        constraint PAIN_FP
            references PAYMENT
);

create index FK1_FUNDINGPAYMENT
    on FUNDINGPAYMENT (SYNCHRONIZATIONPROCESSID);

create index FK2_FUNDINGPAYMENT
    on FUNDINGPAYMENT (PAYMENTID);

create table PENALTYORDER
(
    PENALTYORDERID       NUMBER(19)        not null
        primary key,
    CASHACCOUNTID        NUMBER(19)        not null
        constraint PTYO_CA
            references CASHACCOUNT,
    LINKEDGENERICORDERID NUMBER(19)
        constraint PTYO_LGO
            references GENERICORDER,
    GENERICORDERID       NUMBER(19)        not null
        constraint PTYO_GO
            references GENERICORDER,
    UPDATEDUTC           TIMESTAMP(6)      not null,
    INSTRUMENTID         NUMBER(19)        not null
        constraint PTYO_I
            references INSTRUMENT,
    STATUS               VARCHAR2(50 char) not null
        check (STATUS IN ('PENDING', 'CANCELLED', 'COMPLETED'))
);

create index FK1_PENALTYORDER
    on PENALTYORDER (GENERICORDERID);

create table PENALTYORDERHISTORY
(
    PENALTYORDERID       NUMBER(19)        not null,
    TRANSACTIONID        NUMBER(19)        not null
        primary key,
    CASHACCOUNTID        NUMBER(19)        not null,
    LINKEDGENERICORDERID NUMBER(19),
    GENERICORDERID       NUMBER(19)        not null,
    STATUS               VARCHAR2(50 char) not null
        check (STATUS IN ('PENDING', 'CANCELLED', 'COMPLETED')),
    UPDATEDUTC           TIMESTAMP(6)      not null,
    INSTRUMENTID         NUMBER(19)        not null
);

create table CLIENTINSTRUMENTPREFERENCE
(
    CASHACCOUNTID   NUMBER(19)          not null
        constraint CIP_CA
            references CASHACCOUNT,
    HIDEZEROBALANCE NUMBER(2) default 0 not null
        check ("HIDEZEROBALANCE" = 0 OR "HIDEZEROBALANCE" = 1)
);

create unique index FK1_CLIENTINSTRUMENTPREFERENCE
    on CLIENTINSTRUMENTPREFERENCE (CASHACCOUNTID);

create table CLIENTINSTRUMENTPREFHISTORY
(
    CASHACCOUNTID   NUMBER(19),
    TRANSACTIONID   NUMBER(19),
    HIDEZEROBALANCE NUMBER(2)
);

create table ASAORDERFORMDETAIL
(
    ASAORDERFORMID NUMBER(19)   not null,
    ORDERFORMID    NUMBER(19)   not null
        constraint OF_AOFD
            references ORDERFORM,
    INSTRUMENTID   NUMBER(19)
        constraint INSTRUMENT_AOFD
            references INSTRUMENT,
    AMOUNT         NUMBER(19, 2),
    UPDATEDUTC     TIMESTAMP(6) not null
);

create unique index AK1_ASAORDERFORMDETAIL
    on ASAORDERFORMDETAIL (ASAORDERFORMID);

create unique index FK1_ASAORDERFORMDETAIL
    on ASAORDERFORMDETAIL (ORDERFORMID);

create index FK2_ASAORDERFORMDETAIL
    on ASAORDERFORMDETAIL (INSTRUMENTID);

create table PAYBYBANKORDERFORMDETAIL
(
    PAYBYBANKORDERFORMDETAILID NUMBER(19)        not null,
    ORDERFORMID                NUMBER(19)        not null
        constraint OF_PBOFD
            references ORDERFORM,
    AMOUNT                     NUMBER(19, 2),
    UPDATEDUTC                 TIMESTAMP(6)      not null,
    ORDERREFERENCE             VARCHAR2(16 char) not null
);

create unique index AK1_PAYBYBANKORDERFORMDETAIL
    on PAYBYBANKORDERFORMDETAIL (PAYBYBANKORDERFORMDETAILID);

create unique index FK1_PAYBYBANKORDERFORMDETAIL
    on PAYBYBANKORDERFORMDETAIL (ORDERFORMID);

create table PAYBYBANKORDER
(
    PAYBYBANKORDERID   NUMBER(19)        not null,
    ORDERFORMREFERENCE VARCHAR2(22 char) not null,
    CASHACCOUNTID      NUMBER(19, 2)     not null
        constraint CA_PBO
            references CASHACCOUNT,
    STATUS             VARCHAR2(22 char) not null,
    CREATEDUTC         TIMESTAMP(6)      not null,
    UPDATEDUTC         TIMESTAMP(6)      not null,
    GENERICORDERID     NUMBER(19)        not null
        constraint GO_PBO
            references GENERICORDER,
    MERCHANTPAYMENTID  VARCHAR2(50 char)
);

create table PAYBYBANKORDERHISTORY
(
    PAYBYBANKORDERID   NUMBER(19),
    TRANSACTIONID      NUMBER(19),
    ORDERFORMREFERENCE VARCHAR2(22 char),
    CASHACCOUNTID      NUMBER(19, 2),
    STATUS             VARCHAR2(22 char),
    CREATEDUTC         TIMESTAMP(6),
    UPDATEDUTC         TIMESTAMP(6),
    GENERICORDERID     NUMBER(19),
    MERCHANTPAYMENTID  VARCHAR2(50 char)
);

create table RESTMESSAGE
(
    RESTMESSAGEID NUMBER(19)         not null
        primary key,
    MESSAGEID     VARCHAR2(50 char)  not null,
    MESSAGETYPE   VARCHAR2(5 char)   not null,
    ENDPOINT      VARCHAR2(250 char) not null,
    BODY          VARCHAR2(500 char),
    CREATEDUTC    TIMESTAMP(6)       not null,
    CORRELATIONID VARCHAR2(50 char)
);

create view CASHJOURNALENTRIESVIEW as
SELECT je."JOURNALENTRYID",je."JOURNALID",je."ORDINAL",je."AMOUNT",je."STATUS",je."MOVEMENTTYPE",je."MOVEMENTSUBTYPE",je."REFERENCE",je."CREATEDUTC",je."VALUEUTC",je."PROCESSINGSTARTUTC",je."RECONCILEDUTC",je."FROMCASHMOVEMENTID",je."TOCASHMOVEMENTID",je."NARRATIVE",je."CREATEDBYID",
       cm.cashMovementId,
       cm.cashaccountid,
       cm.mark
  FROM CashMovement cm
  INNER JOIN JournalEntry je ON je.fromCashMovementId = cm.cashMovementId
UNION ALL
SELECT je."JOURNALENTRYID",je."JOURNALID",je."ORDINAL",je."AMOUNT",je."STATUS",je."MOVEMENTTYPE",je."MOVEMENTSUBTYPE",je."REFERENCE",je."CREATEDUTC",je."VALUEUTC",je."PROCESSINGSTARTUTC",je."RECONCILEDUTC",je."FROMCASHMOVEMENTID",je."TOCASHMOVEMENTID",je."NARRATIVE",je."CREATEDBYID",
       cm.cashMovementId,
       cm.cashaccountid,
       cm.mark
  FROM CashMovement cm
  INNER JOIN JournalEntry je ON je.toCashMovementId = cm.cashMovementId
;

create view OLDCASHMOVEMENTVIEW as
select cm.cashMovementId, cm.cashAccountId, je.amount, je.movementType,
       cm.mark, je.status, je.reference, je.createdUtc, je.valueUtc,
       je.reconciledUtc, je.movementSubType AS subMovementType, je.narrative, je.processingStartUtc
  FROM CashMovement cm
  INNER JOIN JournalEntry je ON cm.cashMovementId = je.fromCashMovementId
UNION ALL
select cm.cashMovementId, cm.cashAccountId, je.amount, je.movementType,
       cm.mark, je.status, je.reference, je.createdUtc, je.valueUtc,
       je.reconciledUtc, je.movementSubType AS subMovementType, je.narrative, je.processingStartUtc
  FROM CashMovement cm
  INNER JOIN JournalEntry je ON cm.cashMovementId = je.toCashMovementId
;

create PACKAGE dsBITools
AS
    reportDate_v DATE := trunc(SYSDATE);
    fromDate_v DATE := trunc(SYSDATE) - interval '1' day;

    PROCEDURE setReportDate(reportDate_p IN VARCHAR2);
    PROCEDURE setFromDate(fromDate_p IN VARCHAR2);

    FUNCTION getReportDate RETURN DATE;
    FUNCTION getFromDate RETURN DATE;
END;

create view V_BI_BALANCE as
WITH CA_SNAPSHOT AS (
    SELECT ba.treasuryBlockId,
           ba.accounttype as                                                                                              baaccttype,
           ca.cashAccountId,
           coalesce(cab.amount, 0)                                                                                        amount,
           coalesce(cab.valueUtc, ca.createdUtc) as                                                                       valueUtc,
           trunc(cast(
                       from_tz(coalesce(cab.valueUtc, ca.createdUtc), '+00:00') at time zone sessiontimezone as date)) as valuedate,
           ba.bankAccountId,
           cat.accountType,
           cab.ordinal
    FROM CashAccount ca
             inner join bankaccount ba on ba.bankaccountid = ca.bankaccountid
             INNER JOIN CashAccountType cat on cat.cashAccountTypeId = ca.cashAccountTypeId
             LEFT JOIN CashAccountBalance cab ON cab.cashAccountId = ca.cashAccountId
    WHERE ba.accountType <> 'SETTLEMENT'
),
     CA_BALANCE AS (
         SELECT treasuryblockid, cashAccountId, amount, valuedate, bankAccountId, accountType, baaccttype
         FROM (
                  SELECT treasuryblockid,
                         baaccttype,
                         cashAccountId,
                         amount,
                         valuedate,
                         bankAccountId,
                         accountType,
                         ROW_NUMBER()
                                 OVER (PARTITION BY cashAccountId ORDER BY valueUtc DESC, ordinal DESC) AS Match_val
                  FROM CA_SNAPSHOT
                  WHERE valuedate < dsBITools.getReportDate()
              )
         WHERE match_val = 1
     ),
     UNCLEARED_MOVEMENTS AS (
         SELECT ca.cashAccountId,
                COALESCE(sum(CASE WHEN cje.mark IN ('C', 'RD') THEN cje.amount ELSE -cje.amount END),
                         0) as unclearedamount
         FROM CashAccount ca
                  inner join bankaccount ba on ba.bankaccountid = ca.bankaccountid
                  INNER JOIN CashAccountType cat ON cat.cashAccountTypeId = ca.cashAccountTypeId
                  INNER JOIN CashJournalEntriesView cje ON cje.cashaccountid = ca.cashaccountid
                  INNER JOIN Journal j ON j.journalId = cje.journalId
         WHERE ba.accountType <> 'SETTLEMENT'
           and trunc(cast(from_tz(j.bookedUtc, '+00:00') at time zone sessiontimezone as date)) <
               dsBITools.getReportDate()
           AND cje.movementtype != 'PENDING'
           AND cje.status = 'BOOKED'
           AND j.status in ('BOOKED', 'POSTED')
           AND (cje.reconciledUtc IS NULL OR
                cast(from_tz(cje.reconciledUtc, '+00:00') at time zone sessiontimezone as date) >=
                dsBITools.getReportDate())
         GROUP BY ca.cashaccountid
     )
select r1.clientnum,
       r1.cashaccountid,
       r1.parentcashaccountid,
       r1.cacreatedutc,
       r1.status,
       r1.valuedate,
       r1.rptdate,
       r1.clearedBalance,
       r1.unclearedBalance,
       r1.accountType,
       r1.receipttype,
       r1.sourcecode,
       r1.productname,
       r1.instrumentid,
       r1.instrumentdetailid,
       r1.instrumentname,
       r1.vantagecode,
       r1.bankname,
       r1.bankaccountid,
       r1.bankaccounttype,
       r1.bankaccountname,
       r1.accountgroup,
       r1.accountidentifier,
       r1.treasuryblockid
from (
         SELECT cus.externalreference      AS clientnum,
                ca.cashaccountid,
                ca.parentcashaccountid,
                ca.createdutc              as cacreatedutc,
                ca.status,
                cb.valuedate,
                dsBITools.getReportDate()  as rptdate,
                nvl(cb.amount, 0)          AS clearedBalance,
                NVL(um.unclearedamount, 0) as unclearedBalance,
                (
                    SELECT MAX(instrumentdetailid)
                               KEEP (DENSE_RANK FIRST ORDER BY effectivedateutc) AS instrumentdetailid
                    FROM instrumentdetail it
                    WHERE it.instrumentid = i.instrumentid
                      AND it.effectivedateutc <= dsBITools.getReportDate()
                      and it.status = 'COMPLETED'
                )                          AS instrumentdetailid,
                cat.accountType,
                cao.receipttype,
                cao.sourcecode,
                p.productname,
                i.instrumentid,
                i.externalreference        as instrumentname,
                hlp.code                   as vantagecode,
                pb.bankname,
                ba.bankaccountid,
                ba.accounttype             AS bankaccounttype,
                ba.accountname             AS bankaccountname,
                ba.accountgroup,
                ba.accountidentifier,
                ba.treasuryblockid
         FROM CashAccount ca
                  LEFT JOIN customer cus ON cus.customerid = ca.customerid
                  INNER JOIN BankAccount ba ON ba.bankAccountId = ca.bankAccountId
                  INNER JOIN HlProduct hlp on hlp.hlProductId = ba.hlProductId
                  INNER JOIN CashAccountType cat ON ca.cashAccountTypeId = cat.cashAccountTypeId
                  LEFT join CA_BALANCE CB on cb.cashAccountId = ca.cashAccountId
                  LEFT JOIN UNCLEARED_MOVEMENTS um ON ca.cashAccountId = um.cashaccountId
                  LEFT JOIN instrument i ON i.instrumentid = ca.instrumentid
                  LEFT JOIN product p ON p.productid = i.productid
                  LEFT JOIN cashaccountopening cao ON cao.cashaccountid = ca.cashaccountid
                  LEFT JOIN partnerbank pb ON ba.partnerbankid = pb.partnerbankid
         WHERE trunc(cast(from_tz(ca.createdUtc, '+00:00') at time zone sessiontimezone as date)) <
               dsBITools.getReportDate()
           and ba.accountType <> 'SETTLEMENT'
     ) r1;

create view V_BI_JOURNAL_ENTRY_DETAIL as
WITH debitentries AS
       (
         SELECT
           cm.cashaccountid,
           cm.cashmovementid,
           je.journalentryid,
           j.journalid,
           j.journalgroupid,
           cm.mark,
           je.createdutc,
           wo.PROCESSINGMETHOD,
           je.amount,
           (CASE WHEN mark='D' THEN -je.amount ELSE je.amount END) as samount,
           je.movementtype,
           je.movementsubtype,
           j.journaltype,
           j.journalsubtype,
           j.status,
           je.reconciledutc,
           je.valueutc,
           j.bookedutc,
           je.fromcashmovementid,
           je.tocashmovementid,
           je.reference,
           je.narrative
           FROM journalentry je
           JOIN journal j ON j.journalid = je.journalid
           JOIN cashmovement cm ON cm.cashmovementid = je.fromcashmovementid
           LEFT JOIN CASHMOVEMENT2GENERICORDER CM2GORD on CM2GORD.CASHMOVEMENTID=CM.CASHMOVEMENTID
           LEFT JOIN genericorder gord on gord.genericorderid=cm2gord.genericorderid
           LEFT JOIN withdrawalorder wo on wo.genericorderid=gord.genericorderid
           WHERE
             -- Debit or reverse credit entries
               cm.mark IN ('D', 'RD') AND
               j.status IN ('BOOKED', 'POSTED', 'REVERSED', 'PENDING') AND
             trunc(je.createdutc) between dsBITools.getFromDate() AND dsBITools.getReportDate()--AND
       ),
-- CREDIT entries
     creditentries AS
       (
         SELECT
           cm.cashaccountid,
           cm.cashmovementid,
           je.journalentryid,
           j.journalid,
           j.journalgroupid,
           cm.mark,
           je.createdutc,
           wo.PROCESSINGMETHOD,
           je.amount,
           (CASE WHEN mark='C' THEN je.amount ELSE -je.amount END) as samount,
           je.movementtype,
           je.movementsubtype,
           j.journaltype,
           j.journalsubtype,
           j.status,
           je.reconciledutc,
           je.valueutc,
           j.bookedutc,
           je.fromcashmovementid,
           je.tocashmovementid,
           je.reference,
           je.narrative
           FROM journalentry je
           JOIN journal j ON j.journalid = je.journalid
           JOIN cashmovement cm ON cm.cashmovementid = je.tocashmovementid
           LEFT JOIN CASHMOVEMENT2GENERICORDER CM2GORD on CM2GORD.CASHMOVEMENTID=CM.CASHMOVEMENTID
           LEFT JOIN genericorder gord on gord.genericorderid=cm2gord.genericorderid
           LEFT JOIN withdrawalorder wo on wo.genericorderid=gord.genericorderid
           WHERE
             -- Credit or reverse debit entries
               cm.mark IN ('C', 'RC') AND
             -- Items posted to ledger or due to be posted (booked and reconciled)
               j.status IN ('BOOKED', 'POSTED', 'REVERSED', 'PENDING') AND
             trunc(je.createdutc) between dsBITools.getFromDate() AND dsBITools.getReportDate()--AND
       )
SELECT distinct
  je.CASHACCOUNTID,
  je.CASHMOVEMENTID,
  je.JOURNALENTRYID,
  je.JOURNALID,
  je.JOURNALGROUPID,
  je.MARK,
  je.CREATEDUTC,
  je.PROCESSINGMETHOD,
  je.AMOUNT,
  je.SAMOUNT,
  je.MOVEMENTTYPE,
  je.MOVEMENTSUBTYPE,
  je.JOURNALTYPE,
  je.JOURNALSUBTYPE,
  je.STATUS,
  je.RECONCILEDUTC,
  je.VALUEUTC,
  je.BOOKEDUTC,
  je.FROMCASHMOVEMENTID,
  je.TOCASHMOVEMENTID,
  je.REFERENCE,
  je.NARRATIVE,
  cab.clientnum,
  cab.cacreatedutc,
  cab.accountType,
  cab.receipttype,
  cab.sourcecode,
  cab.productname,
  cab.instrumentid,
  cab.instrumentdetailid,
  cab.instrumentname,
  cab.vantagecode,
  cab.bankname,
  cab.bankaccountid,
  cab.bankaccounttype,
  cab.bankaccountname,
  cab.accountgroup,
  cab.accountidentifier,
  cab.treasuryblockid,
  cab.clearedBalance,
  cab.unclearedBalance,
  it.lengthofterm,
  it.aer,
  it.grossrate,
  it.interesttype,
  it.interestfrequency,
  it.currencycode,
  it.investmentstartdateutc,
  it.investmentenddateutc
  FROM
    (
      -- debits
      SELECT *
        FROM debitentries
      UNION ALL
      -- credits
      SELECT *
        FROM creditentries
    ) je
    inner join V_BI_BALANCE cab on cab.cashaccountid=je.cashaccountid
    LEFT JOIN instrumentdetail it ON it.instrumentdetailid = cab.instrumentdetailid
;

create PACKAGE BODY dsBITools
AS
    PROCEDURE setReportDate(reportDate_p IN VARCHAR2) IS
    BEGIN
        reportDate_v := to_date(reportDate_p, 'YYYYMMDD');
    END setReportDate;

    PROCEDURE setFromDate(fromDate_p IN VARCHAR2) IS
    BEGIN
        fromDate_v := to_date(fromDate_p, 'YYYYMMDD');
    END setFromDate;

    FUNCTION getReportDate RETURN DATE IS
    BEGIN
        RETURN reportDate_v;
    END getReportDate;

    FUNCTION getFromDate RETURN DATE IS
    BEGIN
        RETURN fromDate_v;
    END getFromDate;
END;

create package ptr_calculator is
   /*
    all dates and times are assumed to be local, not UTC
    */
   function add_1_working_day(start_date date) return date;
   function
isBusinessDay(start_date date) return boolean;
   function
isWithinProcessingPeriod(start_date timestamp) return boolean;
   function
rollToProcessingPeriod(start_date timestamp) return timestamp;
   function
getFundsAvailableTargetTime(start_date timestamp) return timestamp;
   function
forwardsDuration (fromTimeIn timestamp, toTimeIn timestamp) return integer;
   function
durationBusinessMinutes (startTimeIn timestamp, stopTimeIn timestamp) return integer;
   function
getTargetForActioning (start_date timestamp) return timestamp;
end;

create package body ptr_calculator is
function add_1_working_day (
  start_date date
) return date as
  end_date date := trunc(start_date) + 1;
  counter
pls_integer := 0;
begin
case
    /*
    BETWEEN dateA and dateB is actually between dateA 00:00:00 and dateB 00:00:00
     */
    when end_date between '23-DEC-23' and '27-DEC-23' then return '27-DEC-23';
when end_date between '30-DEC-23' and '02-JAN-24' then return '02-JAN-24';
when end_date between '29-MAR-24' and '02-APR-24' then return '02-APR-24';
when end_date between '04-MAY-24' and '07-MAY-24' then return '07-MAY-24';
when end_date between '25-MAY-24' and '28-MAY-24' then return '28-MAY-24';
when end_date between '24-AUG-24' and '27-AUG-24' then return '27-AUG-24';
when end_date between '25-DEC-24' and '27-DEC-24' then return '27-DEC-24';
when to_char(end_date, 'fmdy') in ('sat', 'sun') then return next_day(end_date, 'monday');
else return end_date;
end
case;
end add_1_working_day;

function
isBusinessDay (
  start_date date
) return boolean as
begin
  if
to_char(start_date, 'fmdy') in ('sat', 'sun') then
    return false;
end if;

  if
trunc(start_date) in ('25-DEC-23', '26-DEC-23', '01-JAN-24', '29-MAR-24', '01-APR-24', '06-MAY-24', '27-MAY-24',
                      '26-AUG-24', '25-DEC-24', '26-DEC-24') then
    return false;
end if;

return true;
end isBusinessDay;

function
isWithinProcessingPeriod (
  start_date timestamp
) return boolean as
  start_of_business_day timestamp := trunc(start_date) + interval '6' hour;
  end_of_business_day
timestamp := trunc(start_date) + interval '0 17:30:00' day to second;
begin
  if
isBusinessDay(start_date)
    and start_date >= start_of_business_day
    and start_date < end_of_business_day then
        return true;
end if;
return false;
end isWithinProcessingPeriod;

-- used by psr-inbound.sql and psr-out.sql
function
rollToProcessingPeriod (
  start_date timestamp
) return timestamp as
  start_of_business_day timestamp := trunc(start_date) + interval '6' hour;
  next_working_day
date;
begin
  if
isWithinProcessingPeriod(start_date) then
    return start_date;
  elsif
start_date < start_of_business_day then
    return start_of_business_day;
else
    next_working_day := add_1_working_day(start_date);
return next_working_day + interval '6' hour;
end if;
end rollToProcessingPeriod;

-- used by psr-inbound.sql
-- funds must be made available to clients within 2 hours of receipt
function
getFundsAvailableTargetTime (
  start_date timestamp
) return timestamp as
  end_of_business_day date := trunc(start_date) + interval '0 16:30:00' day to second;
  target_time
timestamp;
begin

  target_time
:= rollToProcessingPeriod(start_date) + interval '2' hour;

  if
target_time < end_of_business_day then
    return target_time;
end if;

return rollToProcessingPeriod(target_time) + interval '2' hour;

end getFundsAvailableTargetTime;

function
forwardsDuration (
  fromTimeIn timestamp,   /* assumed to be rolled to processing period */
  toTimeIn timestamp      /* assumed to be rolled to processing period */
) return integer as
  fromTime timestamp := fromTimeIn;
  businessMinutes
number := 0;
  minutesDelta
number := 1;
  minutesBetween
number := 0;
  minutesToEndOfDay
number := 0;
  toTime
timestamp := toTimeIn;
  end_of_business_day
date;
  counter
integer := 0;
begin


  WHILE
fromTime < toTime and minutesDelta > 0 and counter < 100 LOOP
    counter := counter + 1;
--    dbms_output.put_line('looping ' || fromTime);
    fromTime
:= ptr_calculator.rollToProcessingPeriod(fromTime);
--    dbms_output.put_line('from rolled' || fromTime);
    minutesBetween
:= (cast(toTime as date) - cast(fromTime as date)) * 1440;

    end_of_business_day
:= trunc(fromTime) + interval '0 17:30:00' day to second;
    minutesToEndOfDay
:= (end_of_business_day - cast(fromTime as date)) * 1440;

    minutesDelta
:= least(minutesBetween, minutesToEndOfDay);
--    dbms_output.put_line('min d ' || minutesDelta);
    businessMinutes
:= businessMinutes + minutesDelta;
    fromTime
:= fromTime + (minutesDelta / 1440);
--    dbms_output.put_line('from ' || fromTime);
END LOOP;

return round(businessMinutes);

end forwardsDuration;

-- used by psr-inbound.sql and psr-out.sql
function
durationBusinessMinutes (
  startTimeIn timestamp,
  stopTimeIn timestamp
) return integer as
  startTime timestamp;
  stopTime
timestamp;
  negatedDuration
integer;
begin

  startTime
:= rollToProcessingPeriod(startTimeIn);
  --  dbms_output.put_line('start ' || startTime);
  stopTime
:= rollToProcessingPeriod(stopTimeIn);
  -- dbms_output.put_line('stop ' || stopTime);

  if
stopTime < startTime then
    negatedDuration := 0 - forwardsDuration(stopTime, startTime);
return negatedDuration;
end if;

return forwardsDuration(startTime, stopTime);

end durationBusinessMinutes;

-- used by psr-out.sql
function
getTargetForActioning (
  start_date timestamp
) return timestamp as
  effectiveFundsActionableTime timestamp;
  nextBusinessDay
date;
  targetTimeOfDay
timestamp;
  targetForActioning
timestamp;
begin

  effectiveFundsActionableTime
:= rollToProcessingPeriod(start_date);
  nextBusinessDay
:= add_1_working_day(effectiveFundsActionableTime);

  targetTimeOfDay
:= trunc(effectiveFundsActionableTime) + interval '0 17:30:00' day to second;

  if
effectiveFundsActionableTime >= targetTimeOfDay then
    nextBusinessDay := add_1_working_day(nextBusinessDay);
end if;

  targetForActioning
:= nextBusinessDay + interval '0 17:30:00' day to second;

return targetForActioning;

end getTargetForActioning;

end;

create FUNCTION "GET_CASHACCOUNTSEQ" RETURN NUMBER IS
BEGIN
  RETURN seq_CashAccountBalance.nextval;
END;


