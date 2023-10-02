import { Sequelize, DataTypes } from 'sequelize';
import { ModelAttributes, ModelOptions } from 'sequelize';
import { rdbms } from '../resources';
import { winstonLogger } from '../util';

export const sequelize = new Sequelize(rdbms.pgURL, {
  dialect: 'postgres',
  logging: (sql: string) => {
    winstonLogger.debug(sql);
  },
});

const commonSettings = {
  freezeTableName: true,
  timestamps: false,
};

const EducationalMaterial = <EducationalMaterialType>sequelize.define(
  'educationalmaterial',
  {
    id: {
      field: 'id',
      type: DataTypes.BIGINT,
      autoIncrement: true,
      primaryKey: true,
    },
    createdAt: {
      field: 'createdat',
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    publishedAt: {
      field: 'publishedat',
      type: DataTypes.DATE,
      allowNull: true,
    },
    updatedAt: {
      field: 'updatedat',
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    archivedAt: {
      field: 'archivedat',
      type: DataTypes.DATE,
      allowNull: true,
    },
    timeRequired: {
      field: 'timerequired',
      type: DataTypes.TEXT,
      allowNull: false,
      defaultValue: '',
    },
    ageRangeMin: {
      field: 'agerangemin',
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    ageRangeMax: {
      field: 'agerangemax',
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    licenseCode: {
      field: 'licensecode',
      type: DataTypes.TEXT,
      allowNull: false,
      defaultValue: '',
    },
    obsoleted: {
      field: 'obsoleted',
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    originalPublishedAt: {
      field: 'originalpublishedat',
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    usersUserName: {
      field: 'usersusername',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    expires: {
      field: 'expires',
      type: DataTypes.DATE,
      allowNull: true,
    },
    suitsAllEarlyChildhoodSubjects: {
      field: 'suitsallearlychildhoodsubjects',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllPreprimarySubjects: {
      field: 'suitsallpreprimarysubjects',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllBasicStudySubjects: {
      field: 'suitsallbasicstudysubjects',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllUpperSecondarySubjects: {
      field: 'suitsalluppersecondarysubjects',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllVocationalDegrees: {
      field: 'suitsallvocationaldegrees',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllSelfmotivatedSubjects: {
      field: 'suitsallselfmotivatedsubjects',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllBranches: {
      field: 'suitsallbranches',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    suitsAllUpperSecondarySubjectsNew: {
      field: 'suitsalluppersecondarysubjectsnew',
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    },
    ratingContentAverage: {
      field: 'ratingcontentaverage',
      type: DataTypes.DECIMAL,
      allowNull: true,
    },
    ratingVisualAverage: {
      field: 'ratingvisualaverage',
      type: DataTypes.DECIMAL,
      allowNull: true,
    },
    viewCounter: {
      field: 'viewcounter',
      type: DataTypes.BIGINT,
      allowNull: true,
      defaultValue: 0,
    },
    downloadCounter: {
      field: 'downloadcounter',
      type: DataTypes.BIGINT,
      allowNull: true,
      defaultValue: 0,
    },
    counterUpdatedAt: {
      field: 'counterupdatedat',
      type: DataTypes.DATE,
      allowNull: true,
    },
  } as ModelAttributes<EducationalMaterial, unknown>,
  commonSettings as ModelOptions,
);

const Material = <MaterialType>sequelize.define(
  'material',
  {
    id: {
      field: 'id',
      type: DataTypes.BIGINT,
      autoIncrement: true,
      primaryKey: true,
    },
    link: {
      field: 'link',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    educationalMaterialId: {
      field: 'educationalmaterialid',
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: EducationalMaterial, // Can be the table name 'educationalmaterial' or the Sequelize model EducationalMaterial
        key: 'id',
      },
    },
    obsoleted: {
      field: 'obsoleted',
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    priority: {
      field: 'priority',
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    materialLanguageKey: {
      field: 'materiallanguagekey',
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  } as ModelAttributes<Material, unknown>,
  commonSettings as ModelOptions,
);

const MaterialDisplayName = <MaterialDisplayNameType>sequelize.define(
  'materialdisplayname',
  {
    id: {
      field: 'id',
      type: DataTypes.BIGINT,
      autoIncrement: true,
      primaryKey: true,
    },
    displayName: {
      field: 'displayname',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    language: {
      field: 'language',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    materialId: {
      field: 'materialid',
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: Material, // Can be the table name 'material' or the Sequelize model Material
        key: 'id',
      },
    },
  } as ModelAttributes<MaterialDisplayName, unknown>,
  commonSettings as ModelOptions,
);

const TemporaryRecord = <TemporaryRecordType>sequelize.define(
  'temporaryrecord',
  {
    id: {
      field: 'id',
      type: DataTypes.BIGINT,
      autoIncrement: true,
      primaryKey: true,
    },
    filePath: {
      field: 'filepath',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    originalFileName: {
      field: 'originalfilename',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    fileSize: {
      field: 'filesize',
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    mimeType: {
      field: 'mimetype',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    format: {
      field: 'format',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    fileName: {
      field: 'filename',
      type: DataTypes.TEXT,
      allowNull: false,
    },
    materialId: {
      field: 'materialid',
      type: DataTypes.BIGINT,
      allowNull: false,
      references: {
        model: Material, // Can be the table name 'material' or the Sequelize model Material
        key: 'id',
      },
    },
    createdAt: {
      field: 'createdat',
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
  } as ModelAttributes<TemporaryRecord, unknown>,
  commonSettings as ModelOptions,
);

// EducationalMaterial <=> Material
EducationalMaterial.hasMany(Material, {
  foreignKey: 'educationalMaterialId',
  as: 'materials',
});
Material.belongsTo(EducationalMaterial, {
  foreignKey: 'educationalMaterialId',
});

// Material <=> MaterialDisplayName
Material.hasMany(MaterialDisplayName, {
  foreignKey: 'materialId',
  as: 'materialDisplayNames',
});
MaterialDisplayName.belongsTo(Material, {
  foreignKey: 'materialId',
});

export { EducationalMaterial, Material, MaterialDisplayName, TemporaryRecord };
