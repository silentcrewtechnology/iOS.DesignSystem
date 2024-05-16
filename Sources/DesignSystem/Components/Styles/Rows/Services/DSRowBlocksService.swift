import UIKit

public struct DSRowBlocksService {
    public static func createRowBlock(_ block: DSRowBlocks?) -> UIView? {
        guard let block else { return nil }
        switch block {
        case .atom(let atom):
            return createAtom(atom)
        case .molecule(let molecule):
            return createMolecule(molecule)
        }
    }
}

private extension DSRowBlocksService {
    private static func createAtom(_ atom: AtomDSElement) -> UIView? {
        let atomService = DSAtomStyleService()
        return atomService.createAtom(atom)
    }
    
    private static func createMolecule(_ molecule: DSMoleculeElement) -> UIView? {
        let moleculeService = DSMoleculeStyleService()
        return moleculeService.createMolecule(molecule)
    }
}
