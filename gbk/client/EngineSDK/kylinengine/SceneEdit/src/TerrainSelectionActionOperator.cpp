#include "TerrainSelectionActionOperator.h"
#include "GridInfoFlagModifyOperator.h"
#include "WXModifyTerrainPaintOperator.h"
#include "WXModifyTerrainHeightOperator.h"
#include "WXModifyTerrainDiffuseOperator.h"
#include "SceneManipulator.h"

namespace Fairy {

    TerrainSelectionActionOperator::TerrainSelectionActionOperator(SceneManipulator* sceneManipulator)
    {
        assert(sceneManipulator);
        
        mFlipDiagonalOperator = new FlipTerrainDiagonalOperator(sceneManipulator);
        mModifyHeightOperator = new ModifyTerrainHeightOperator(sceneManipulator);
        mModifyPaintOperator = new ModifyTerrainPaintOperator(sceneManipulator);
		mModifyTerrainDiffuseOperator = new ModifyTerrainDiffuseOperator(sceneManipulator);
    }

    TerrainSelectionActionOperator::~TerrainSelectionActionOperator()
    {
        if (mFlipDiagonalOperator)
        {
            delete mFlipDiagonalOperator;
            mFlipDiagonalOperator = 0;
        }
        if (mModifyPaintOperator)
        {
            delete mModifyPaintOperator;
            mModifyPaintOperator = 0;
        }
        if (mModifyHeightOperator)
        {
            delete mModifyHeightOperator;
            mModifyHeightOperator = 0;
        }

		if (mModifyTerrainDiffuseOperator)
		{
			delete mModifyTerrainDiffuseOperator;
			mModifyTerrainDiffuseOperator = 0;
		}
    }

    bool TerrainSelectionActionOperator::empty(void) const
    {
        assert (mFlipDiagonalOperator && mModifyHeightOperator && mModifyPaintOperator && mModifyTerrainDiffuseOperator);

        return mFlipDiagonalOperator->empty() &&
            mModifyHeightOperator->empty() &&
            mModifyPaintOperator->empty() &&
			mModifyTerrainDiffuseOperator->empty();
    }

    const String& TerrainSelectionActionOperator::getGroupName(void) const
    {
        static const String groupName = "GridDiagonalFlipFlag";
        return groupName;
    }
    //-----------------------------------------------------------------------
    String TerrainSelectionActionOperator::getDescription(void) const
    {
        // TODO:
        return "";
    }
    //-----------------------------------------------------------------------
    String TerrainSelectionActionOperator::getHelp(void) const
    {
        // TODO
        return "";
    }

    void TerrainSelectionActionOperator::undo(void)
    {
        assert (mFlipDiagonalOperator && mModifyHeightOperator && mModifyPaintOperator && mModifyTerrainDiffuseOperator);

        mFlipDiagonalOperator->undo();
        mModifyHeightOperator->undo();
        mModifyPaintOperator->undo();
		mModifyTerrainDiffuseOperator->undo();
    }

    void TerrainSelectionActionOperator::redo(void)
    {
        assert (mFlipDiagonalOperator && mModifyHeightOperator && mModifyPaintOperator && mModifyTerrainDiffuseOperator);

        mFlipDiagonalOperator->redo();
        mModifyHeightOperator->redo();
        mModifyPaintOperator->redo();
		mModifyTerrainDiffuseOperator->redo();
    }

}