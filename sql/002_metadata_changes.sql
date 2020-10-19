ALTER TABLE isbasedon ALTER COLUMN author DROP not null;
ALTER TABLE Material ALTER COLUMN MaterialLanguageKey TYPE TEXT;

ALTER TABLE IF EXISTS isbasedon DROP CONSTRAINT constraint_isbasedon;
ALTER TABLE isbasedon ADD CONSTRAINT constraint_isbasedon UNIQUE (materialname,educationalmaterialid);

CREATE TABLE IsBasedOnAuthor (
  Id           BIGSERIAL NOT NULL, 
  AuthorName  text NOT NULL, 
  IsBasedOnId int8 NOT NULL, 
  PRIMARY KEY (Id));
ALTER TABLE IsBasedOnAuthor ADD CONSTRAINT FKIsBasedOnAuthor FOREIGN KEY (IsBasedOnId) REFERENCES IsBasedOn (Id);

ALTER TABLE isbasedon DROP COLUMN author;

ALTER TABLE attachment ADD COLUMN Obsoleted int4 DEFAULT 0 NOT NULL;

--24.3.2020 feat-582
ALTER TABLE educationalmaterial ADD COLUMN SuitsAllUpperSecondarySubjectsNew bool DEFAULT 'false' NOT NULL;

--feat 592
CREATE TABLE Rating (
  Id                     BIGSERIAL NOT NULL, 
  RatingContent         int4, 
  RatingVisual          int4, 
  FeedbackPositive      varchar(1000), 
  FeedbackSuggest       varchar(1000), 
  FeedbackPurpose       varchar(1000), 
  EducationalMaterialId int8 NOT NULL, 
  UsersUserName         text NOT NULL,
  UpdatedAt        timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (Id));
ALTER TABLE Rating ADD CONSTRAINT FKRatingUsers FOREIGN KEY (UsersUserName) REFERENCES Users (UserName);
ALTER TABLE Rating ADD CONSTRAINT FKRatingEducationalMaterial FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id);
ALTER TABLE Rating ADD CONSTRAINT constraint_Rating UNIQUE (UsersUserName,educationalmaterialid);
ALTER TABLE educationalmaterial ADD COLUMN RatingContentAverage NUMERIC (2, 1);
ALTER TABLE educationalmaterial ADD COLUMN RatingVisualAverage NUMERIC (2, 1);

--feat 628
ALTER TABLE educationalmaterial ALTER COLUMN agerangemin DROP DEFAULT;
ALTER TABLE educationalmaterial ALTER COLUMN agerangemin DROP NOT NULL;
ALTER TABLE educationalmaterial ALTER COLUMN agerangemax DROP DEFAULT;
ALTER TABLE educationalmaterial ALTER COLUMN agerangemax DROP NOT NULL;
ALTER TABLE educationalmaterial ALTER COLUMN expires DROP NOT NULL;
ALTER TABLE alignmentobject DROP CONSTRAINT constraint_alignmentobject;
ALTER TABLE alignmentobject ADD CONSTRAINT constraint_alignmentobject UNIQUE (alignmentType, objectkey, source, educationalmaterialid);

-- 2.0.0

CREATE TABLE VersionComposition (
  EducationalMaterialId int8 NOT NULL, 
  MaterialId            int8 NOT NULL, 
  PublishedAt           timestamp NOT NULL, 
  Priority              int4, 
  PRIMARY KEY (EducationalMaterialId, 
  MaterialId, 
  PublishedAt));
ALTER TABLE VersionComposition ADD CONSTRAINT FKMaterialVersion FOREIGN KEY (MaterialId) REFERENCES Material (Id);
ALTER TABLE VersionComposition ADD CONSTRAINT FKEducationalMaterialVersion FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id);

INSERT INTO VersionComposition (EducationalMaterialId, PublishedAt, MaterialId, priority)
SELECT em.Id as EducationalMaterialId, em.PublishedAt::timestamp(3), m.Id as MaterialId, m.Priority
FROM EducationalMaterial AS em
JOIN Material AS m
ON em.Id = m.EducationalMaterialId
WHERE em.PublishedAt IS NOT NULL;
--ON CONFLICT (EducationalMaterialId, PublishedAt, MaterialId) DO NOTHING;

CREATE TABLE AttachmentVersionComposition (
  VersionEducationalMaterialId int8 NOT NULL, 
  VersionMaterialId            int8 NOT NULL, 
  VersionPublishedAt           timestamp NOT NULL, 
  AttachmentId                            int8 NOT NULL, 
  PRIMARY KEY (VersionEducationalMaterialId, 
  VersionMaterialId, 
  VersionPublishedAt, 
  AttachmentId));
ALTER TABLE AttachmentVersionComposition ADD CONSTRAINT FKVersionCompositionAttachment FOREIGN KEY (VersionEducationalMaterialId, VersionMaterialId, VersionPublishedAt) REFERENCES VersionComposition (EducationalMaterialId, MaterialId, PublishedAt);
ALTER TABLE AttachmentVersionComposition ADD CONSTRAINT FKAttachmentVersion FOREIGN KEY (AttachmentId) REFERENCES Attachment (Id);


INSERT INTO AttachmentVersionComposition (VersionEducationalMaterialId, VersionPublishedAt, VersionMaterialId, AttachmentId)
SELECT em.Id as EducationalMaterialId, em.PublishedAt::timestamp(3), m.Id as MaterialId, attachment.id
FROM EducationalMaterial AS em
JOIN Material AS m
ON em.Id = m.EducationalMaterialId
JOIN attachment
ON m.id = attachment.MaterialId
WHERE em.PublishedAt IS NOT NULL;

-- readable codes

CREATE TABLE LicenseCode (
  Code text NOT NULL, 
  License text NOT NULL, 
  PRIMARY KEY (Code));

INSERT INTO LicenseCode (Code, License) VALUES ('CCBY4.0', 'CC BY 4.0');
INSERT INTO LicenseCode (Code, License) VALUES ('CCBYNC4.0', 'CC BY-NC 4.0');
INSERT INTO LicenseCode (Code, License) VALUES ('CCBYNCND4.0', 'CC BY-NC-ND 4.0');
INSERT INTO LicenseCode (Code, License) VALUES ('CCBYNCSA4.0', 'CC BY-NC-SA 4.0');
INSERT INTO LicenseCode (Code, License) VALUES ('CCBYND4.0', 'CC BY-ND 4.0');
INSERT INTO LicenseCode (Code, License) VALUES ('CCBYSA4.0', 'CC BY-SA 4.0');

-- feat-674
ALTER TABLE TemporaryAttachment ADD COLUMN AttachmentId int8 NOT NULL;
ALTER TABLE TemporaryAttachment ADD CONSTRAINT FKTempAttachment FOREIGN KEY (AttachmentId) REFERENCES Attachment (Id);
ALTER TABLE Attachment ALTER COLUMN filebucket drop not null;
ALTER TABLE Attachment ALTER COLUMN filepath drop not null;
ALTER TABLE Attachment ALTER COLUMN filekey drop not null;
ALTER TABLE TemporaryAttachment DROP COLUMN materialid;

--3.0.0

-- Collection

CREATE TABLE CollectionEducationalMaterial (
  CollectionId          int8 NOT NULL, 
  EducationalMaterialId int8 NOT NULL, 
  PRIMARY KEY (CollectionId, 
  EducationalMaterialId));
CREATE TABLE Collection (
  Id              BIGSERIAL NOT NULL, 
  CreatedAt      timestamp with time zone NOT NULL, 
  UpdatedAt      timestamp with time zone, 
  PublishedAt    timestamp with time zone, 
  CreatedBy      text NOT NULL, 
  AgeRangeMin    int4, 
  AgeRangeMax    int4, 
  CollectionName text NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE UsersCollection (
  CollectionId  int8 NOT NULL, 
  UsersUserName text NOT NULL, 
  PRIMARY KEY (CollectionId, 
  UsersUserName));
ALTER TABLE CollectionEducationalMaterial ADD CONSTRAINT FKMaterialCollection FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id) ON DELETE Restrict;
ALTER TABLE UsersCollection ADD CONSTRAINT FKUsersCollection FOREIGN KEY (UsersUserName) REFERENCES Users (UserName);
ALTER TABLE CollectionEducationalMaterial ADD CONSTRAINT FKCollectionMaterial FOREIGN KEY (CollectionId) REFERENCES Collection (Id) ON DELETE Cascade;
ALTER TABLE UsersCollection ADD CONSTRAINT FKCollectionUsers FOREIGN KEY (CollectionId) REFERENCES Collection (Id) ON DELETE Cascade;

--begin feat 112

ALTER TABLE Collection ADD COLUMN Description text;

CREATE TABLE CollectionKeyWord (
  Id            BIGSERIAL NOT NULL, 
  Value        text NOT NULL, 
  CollectionId int8 NOT NULL, 
  KeywordKey   text NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE CollectionAlignmentObject (
  Id                    BIGSERIAL NOT NULL, 
  AlignmentType        text NOT NULL, 
  CollectionId         int8 NOT NULL, 
  TargetName           text NOT NULL, 
  Source               text NOT NULL, 
  EducationalFramework text NOT NULL, 
  ObjectKey            text NOT NULL, 
  TargetUrl            text, 
  PRIMARY KEY (Id));
CREATE TABLE CollectionEducationalUse (
  Id                 BIGSERIAL NOT NULL, 
  EducationalUseKey text NOT NULL, 
  CollectionId      int8 NOT NULL, 
  Value             text NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE CollectionLanguage (
  Id            BIGSERIAL NOT NULL, 
  Language     text NOT NULL, 
  CollectionId int8 NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE CollectionEducationalAudience (
  Id                  BIGSERIAL NOT NULL, 
  EducationalRole    text NOT NULL, 
  CollectionId       int8 NOT NULL, 
  EducationalRoleKey text NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE CollectionAccessibilityHazard (
  Id                      BIGSERIAL NOT NULL, 
  Value                  text NOT NULL, 
  AccessibilityHazardKey text NOT NULL, 
  CollectionId           int8 NOT NULL, 
  PRIMARY KEY (Id));
CREATE TABLE CollectionAccessibilityFeature (
  Id                       SERIAL NOT NULL, 
  Value                   text NOT NULL, 
  AccessibilityFeatureKey text NOT NULL, 
  CollectionId            int8 NOT NULL, 
  PRIMARY KEY (Id));
  
ALTER TABLE CollectionAccessibilityHazard ADD CONSTRAINT FKCollectionAccessibilityHazard FOREIGN KEY (CollectionId) REFERENCES Collection (Id);
ALTER TABLE CollectionAccessibilityFeature ADD CONSTRAINT FKCollectionAccessibilityFeature FOREIGN KEY (CollectionId) REFERENCES Collection (Id);
ALTER TABLE CollectionEducationalAudience ADD CONSTRAINT FKCollectionEducationalAudience FOREIGN KEY (CollectionId) REFERENCES Collection (Id) ON DELETE Cascade;
ALTER TABLE CollectionEducationalUse ADD CONSTRAINT FKCollectionEducationalUse FOREIGN KEY (CollectionId) REFERENCES Collection (Id) ON DELETE Cascade;
ALTER TABLE CollectionAlignmentObject ADD CONSTRAINT FKCollectionAligmentObject FOREIGN KEY (CollectionId) REFERENCES Collection (Id) ON DELETE Cascade;
ALTER TABLE CollectionLanguage ADD CONSTRAINT FKCollectionLanguage FOREIGN KEY (CollectionId) REFERENCES Collection (Id) ON DELETE Cascade;
ALTER TABLE CollectionKeyWord ADD CONSTRAINT FKCollectionKeyWords FOREIGN KEY (CollectionId) REFERENCES Collection (Id) ON DELETE Cascade;

--end feat 112

-- faet 112 headings and priority
ALTER TABLE Collection ALTER COLUMN Description TYPE varchar(2000);
ALTER TABLE Collection ALTER COLUMN CollectionName TYPE varchar(255);
ALTER TABLE CollectionEducationalMaterial ADD COLUMN Priority int4 DEFAULT 0 NOT NULL;

CREATE TABLE CollectionHeading (
  Id            BIGSERIAL NOT NULL, 
  Heading      varchar(255) NOT NULL, 
  Description  varchar(2000), 
  Priority     int4 DEFAULT 0 NOT NULL, 
  CollectionId int8 NOT NULL, 
  PRIMARY KEY (Id));
ALTER TABLE CollectionHeading ADD CONSTRAINT FKCollectionHeading FOREIGN KEY (CollectionId) REFERENCES Collection (Id);

CREATE TABLE CollectionEducationalLevel (
  Id                   BIGSERIAL NOT NULL, 
  EducationalLevelKey text NOT NULL, 
  CollectionId        int8 NOT NULL, 
  Value               text NOT NULL, 
  PRIMARY KEY (Id));
ALTER TABLE CollectionEducationalLevel ADD CONSTRAINT FKCollectionEducationalLevel FOREIGN KEY (CollectionId) REFERENCES Collection (Id) ON DELETE Cascade;

-- CollectionAlignmentObject educationalframework can be null

ALTER TABLE collectionalignmentobject ALTER COLUMN educationalframework drop not null;

--feat 739

CREATE TABLE collectionthumbnail (
  id            BIGSERIAL NOT NULL, 
  filepath     text NOT NULL, 
  mimetype     text NOT NULL, 
  filename     text NOT NULL, 
  obsoleted    int4 DEFAULT 0 NOT NULL, 
  filekey      text NOT NULL, 
  filebucket   text NOT NULL, 
  collectionid int8 NOT NULL, 
  PRIMARY KEY (id));
ALTER TABLE collectionthumbnail ADD CONSTRAINT FKCollectionThumbnail FOREIGN KEY (collectionid) REFERENCES Collection (Id);

-- Change default priority
ALTER TABLE collectioneducationalmaterial ALTER COLUMN priority SET DEFAULT 999;
ALTER TABLE collectionheading ALTER COLUMN priority SET DEFAULT 999;

ALTER TABLE educationalmaterial ADD COLUMN viewcounter int8 DEFAULT 0;
ALTER TABLE educationalmaterial ADD COLUMN downloadcounter int8 DEFAULT 0;
ALTER TABLE educationalmaterial ADD COLUMN counterupdatedat timestamp with time zone;
